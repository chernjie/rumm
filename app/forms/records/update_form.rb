class Records::UpdateForm < MVCLI::Form
  input :id,       String
  input :type,     String
  input :name,     String
  input :data,     String
  input :ttl,      String
  input :priority, String
end
