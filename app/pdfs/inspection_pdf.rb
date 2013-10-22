class InspectionPdf < Prawn::Document
  
  def initialize(inspection, view)
    super(margin: 20)
    @inspection = inspection
    @view = view
    logo_box
    header_box
    address
    rooms
    images
    room_images
  end
  
  def logo_box
    bounding_box([bounds.left, bounds.top], width: 300) do
      image "#{Rails.root}/app/assets/images/logo.png"
    end
  end
  
  def header_box
    bounding_box([bounds.right - 250, bounds.top], width: 250) do
      move_down 10
      font_size(12)
      table([["Inspection Date:","#{@inspection.inspection_date}" ]], width: 250, column_widths: [125, 125], :cell_style => { :borders => [:bottom], :padding => 10 })
      table([["Inspection Type:","#{@inspection.inspection_type }" ]], width: 250, column_widths: [125, 125], :cell_style => { :borders => [:bottom], :padding => 10 })
      table([["Inspected By:","#{@inspection.inspected_by}" ]], width: 250, column_widths: [125, 125], :cell_style => { :borders => [], :padding => 10 })
    end
  end
  
  def address
    move_down(20)
    font_size(18) do
      text @inspection.full_address
    end
    move_down 40
  end

  def rooms
    @inspection.inspected_rooms.each do |room|
      text room.name, size: 25, align: :center
      stroke do
        stroke_color "EEEEEE"
        horizontal_rule
      end
      move_down 20
      features = [["Feature", "Condition", "Cleanliness", "Marks & Damage", "Comments"]]
      features += room.inspected_features.map{|x| [humanize(x.name), humanize(x.condition), true_to_clean(x.clean), marks_and_damage(x.marks, x.damage), x.comment]}
      font_size(10) do
        table(features, :width => bounds.right, :row_colors => ["EEEEEE", "FFFFFF"], :header => true) do
          cells.borders = [:bottom]
          cells.padding = [10, 5, 10, 5]
          row(0).font_style = :bold
          columns(1..3).align = :center
          columns(4).width = 200
        end
      end
      start_new_page
    end
  end
  
  def images
    text "Property Images", size: 25, align: :center
    stroke do
      stroke_color "EEEEEE"
      horizontal_rule
    end
    move_down 20
    image_urls = @inspection.images.map(&:asset_url)
    y_index = cursor
    width = bounds.right/3
    height = bounds.right/3
    image_urls.in_groups_of(3) do |image_row|
      image_row.each_with_index do |image_file, index|
        bounding_box([bounds.left + (width*index), y_index], width: width, height: height) do
          if image_file
            image open(image_file), fit: [width-20, height-20], position: :center
          end
        end
      end
      y_index -= height
    end
  end
  
  def room_images
    @inspection.inspected_rooms.each do |room|
      if room.images.any?
        start_new_page
        text "#{room.name} Images", size: 25, align: :center
        stroke do
          stroke_color "EEEEEE"
          horizontal_rule
        end
        move_down 20
        image_urls = room.images.map(&:small_url)
        y_index = cursor
        width = bounds.right/3
        height = bounds.right/3
        image_urls.in_groups_of(3) do |image_row|
          image_row.each_with_index do |image_file, index|
            bounding_box([bounds.left + (width*index), y_index], width: width, height: height) do
              if image_file
                image open(image_file), fit: [width-20, height-20], position: :center
              end
            end
          end
          y_index -= height
        end
      end
    end
  end
  
  def humanize(string)
      string.to_s.humanize
  end
  
  def true_to_clean(string)
    if string == true
      "Clean"
    elsif string == false
      "Dirty"
    else
      ""
    end
  end
  
  def marks_and_damage(marks, damage)
    if marks == true && damage == true
      "Marks & Damage"
    elsif marks == true
      "Marks"
    elsif damage == true
      "Damage"
    else
      ""
    end
  end
  
  
end