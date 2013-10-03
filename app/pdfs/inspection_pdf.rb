class InspectionPdf < Prawn::Document
  
  def initialize(inspection)
    super(top_margin: 70)
    @inspection = inspection
    text "Inspection address #{@inspection.address}"
  end
  
end