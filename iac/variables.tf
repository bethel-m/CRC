variable "GODADDY_API_KEY" {
  description = "the api key for accessing the godaddy api"
}
variable "GODADDY_API_SECRET" {
  description = "the secret to the godaddy api"
}
variable "subdomain_CNAME" {
  description = "this is the subdomain(CNAME record) to be created and attached to the cloudfront domain name"
  default = "me"
}
variable "record_type" {
  description = "this is the record type to be created for the cloudfront domain name"
  default = "CNAME"
}