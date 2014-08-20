class Records::CreateForm < MVCLI::Form
  input :name,     String
  input :type,     String
  input :data,     String
  input :ttl,      String
  input :priority, String
end
