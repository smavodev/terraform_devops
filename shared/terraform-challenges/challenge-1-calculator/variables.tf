variable "instances" {
  description = "Instancias con cantidad, tipo y horas"
  type = map(object({
    count = number
    type  = string
    hours = number
  }))
}
