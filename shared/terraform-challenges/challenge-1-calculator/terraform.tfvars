instances = {
  frontend = {
    count = 2
    type  = "t3.micro"
    hours = 120
  }
  backend = {
    count = 1
    type  = "t3.medium"
    hours = 160
  }
}
