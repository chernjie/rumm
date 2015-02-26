class Metadata::CreateForm < MVCLI::Form
  requires :naming
  input :key, String
  input :value, String
end
