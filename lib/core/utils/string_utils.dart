String getNameInitials(String firstName, String lastName){
  String initialFirstName = firstName.substring(0,1).toUpperCase();
  String initialLastName = lastName.substring(0,1).toUpperCase();
  String initial = initialFirstName + initialLastName;
  return initial;
}
