variable "username" {
  description = "Enter your username for the VPX"
  type        = string
}
variable "password" {
  description = "Enter your password for the VPX"
  type        = string
  sensitive = true
}


resource "citrixadc_nsip" "tf_nsip" {
    ipaddress = var.subnetip
    type      = "SNIP"
    netmask   = var.netmask
    vserver = "DISABLED"
    mgmtaccess = "DISABLED"

    lifecycle {
      prevent_destroy = true
    }
}

resource "citrixadc_route" "tf_route" {
    network    = "0.0.0.0"
    netmask    = "0.0.0.0"
    gateway    = var.gateway
    distance   = 1
    weight = 1
    cost = 0

              depends_on = [
    citrixadc_nsip.tf_nsip
  ]

      lifecycle {
      prevent_destroy = true
    }
}

resource "citrixadc_nsfeature" "tf_nsfeature" {
    cs = true
    lb = true
    ssl = true
    responder = true
    appflow = true
    rewrite = true

        lifecycle {
      prevent_destroy = true
    }
    
}

resource "citrixadc_auditsyslogglobal_auditsyslogpolicy_binding" "tf_auditsyslogglobal_auditsyslogpolicy_binding" {
  policyname = citrixadc_auditsyslogpolicy.tf_auditsyslogpolicy.name
  priority   = 100
  globalbindtype = "SYSTEM_GLOBAL"

      lifecycle {
      prevent_destroy = true
    }
}

resource "citrixadc_auditsyslogpolicy" "tf_auditsyslogpolicy" {
    name = "ncop-infp-lba01-pol"
    rule = "true"
    action = citrixadc_auditsyslogaction.tf_syslogaction.name

        lifecycle {
      prevent_destroy = true
    }
}

resource "citrixadc_auditsyslogaction" "tf_syslogaction" {
    name = "ncop-logp-lba04.noc02.nchosting.dk"
    serverip = "100.64.8.100"
    serverport = 514
    loglevel = [
        "ALL"
    ]
    logfacility = "LOCAL0"
    dateformat = "YYYYMMDD"
    timezone = "GMT_TIME"
    tcp = "ALL"
    acl = "ENABLED"
    userdefinedauditlog = "YES"
    appflowexport = "ENABLED"
    lsn = "ENABLED"
    subscriberlog = "ENABLED"
    dns = "ENABLED"
    sslinterception = "ENABLED"
    urlfiltering = "ENABLED"
    contentinspectionlog = "ENABLED"
    transport = "UDP"

        lifecycle {
      prevent_destroy = true
    }

}
