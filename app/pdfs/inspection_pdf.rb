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
  end

  def rooms
    move_down 20
    @inspection.inspected_rooms.each do |room|
      text room.name, size: 25, align: :center
      stroke do
        stroke_color "AAAAAA"
        horizontal_rule
      end
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
    text "Inspection Images", size: 25, align: :center
    stroke do
      stroke_color "EEEEEE"
      horizontal_rule
    end
    move_down 20
    image_urls = @inspection.images.map(&:asset_url)
    y_index = cursor
    width = bounds.right/3
    height = 100
    image_urls.in_groups_of(3) do |image_row|
      image_row.each_with_index do |image_file, index|
        bounding_box([bounds.left + (width*index), y_index], width: width, height: height) do
          if image_file
            image open(image_file), fit: [width, height]
          end
        end
      end
      y_index -= height
    end
    move_down 20
  end
  
  def room_images
    move_down 20
    @inspection.inspected_rooms.each do |room|
      if room.images.any?
        text room.name, size: 15
        move_down 10
        image_urls = room.images.map(&:asset_url)
        y_index = cursor
        width = bounds.right/3
        height = 100
        image_urls.in_groups_of(3) do |image_row|
          image_row.each_with_index do |image_file, index|
            bounding_box([bounds.left + (width*index), y_index], width: width, height: height) do
              if image_file
                image open(image_file), fit: [width, height]
              end
            end
          end
          y_index -= height
        end
      end
      move_down 20
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