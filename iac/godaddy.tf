
# this is data from importing existing godaddy records
resource "godaddy_domain_record" "bethelmmadu" {
    addresses   = []
    domain      = "bethelmmadu.site"
    nameservers = [
        "ns23.domaincontrol.com",
        "ns24.domaincontrol.com",
    ]
    customer = null 
    record {
        data= "@"
        name = "www"
        port= 0
        priority= 0
        protocol= ""
        service= ""
        ttl= 3600
        type= "CNAME"
        weight= 0
    } 

    # note to change the data to a your server ip address
    record{
        data= "127.0.0.1" 
        name= "@" 
        port= 0 
        priority= 0 
        protocol= "" 
        service= "" 
        ttl= 600 
        type= "A" 
        weight= 0
    } 
    record{
        data= "_domainconnect.gd.domaincontrol.com" 
        name= "_domainconnect" 
        port= 0 
        priority= 0 
        protocol= "" 
        service= "" 
        ttl= 3600 
        type= "CNAME" 
        weight= 0
    } 

 }

# this block tries to perform dns validation by creating records that match that provided by acm
resource "godaddy_domain_record" "validation" {
    customer = null 
        for_each = {
                 for name in aws_acm_certificate.bethelmmadu_cert.domain_validation_options:
                  name.domain_name => name
        }
        domain = "bethelmmadu.site"
        record {
        data= each.value.resource_record_value
        name= each.value.resource_record_name
        port= 0 
        priority= 0 
        protocol= "" 
        service= "" 
        ttl= 3600 
        type= each.value.resource_record_type
        weight= 0
        }


        depends_on = [
          aws_acm_certificate.bethelmmadu_cert
        ]
}

# this block creates record for "me" subdomain, that is linked to the cloudfront domain name
resource "godaddy_domain_record" "me_CNAME" {
    customer = null
    domain = "bethelmmadu.site"
    record {
        data = module.cloudfront.cloudfront_domain_name
        name = var.subdomain_CNAME
        ttl = 300
        type = var.record_type        
    }
    depends_on = [
      module.s3,module.cloudfront,godaddy_domain_record.validation
    ]
  
}