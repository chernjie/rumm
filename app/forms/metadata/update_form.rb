class Metadata::UpdateForm < MVCLI::Form
  requires :naming
  input :value, String
end
