class Domains::UpdateForm < MVCLI::Form
  input :name, String
  input :email, String
  input :ttl, String
end
