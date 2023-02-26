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

resource "godaddy_domain_record" "validation" {
      #domain      = "bethelmmadu.site"
    # nameservers = [
    #     "ns23.domaincontrol.com",
    #     "ns24.domaincontrol.com",
    # ]
    customer = null 
        #for_each =toset([ aws_acm_certificate.bethelmmadu_cert.domain_validation_options ])
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