
# How to create and setup a self-signed TLS certificate for TLS SIP signaling

1. create certificates with openssl in your Kamailio sever

    ```bash
    cd /etc/ssl
    mkdir ca
    cd ca
    mkdir demoCA  #default CA name, edit /etc/ssl/openssl.cnf
    mkdir demoCA/private
    mkdir demoCA/newcerts
    touch demoCA/index.txt
    echo 01 >demoCA/serial
    echo 01 >demoCA/crlnumber

    openssl genrsa -out demoCA/private/cakey.pem 2048
    chmod 600 demoCA/private/cakey.pem

    openssl req -out demoCA/cacert.pem -x509 -new -key demoCA/private/cakey.pem
    # It's quite important to compile correctly the conf in this way; in particolar Organization Name and Common Name with the used domain
      #  Organization Name (eg, company) [Internet Widgits Pty Ltd]:your-company
      #  Common Name (e.g. server FQDN or YOUR name) []:your.domain.com
      # Email Address []: your-email@your.domain.com
    openssl req -out kamailio1_cert_req.pem -new -nodes
    # Same story here
      #  Organization Name (eg, company) [Internet Widgits Pty Ltd]:your-company
      # Common Name (e.g. server FQDN or YOUR name) []:your.domain.com
      # Email Address []: your-email@your.domain.com

    openssl ca -in kamailio1_cert_req.pem -out kamailio1_cert.pem

    set DOMAIN your.domain.com
    cp kamailio1_cert.pem /etc/kamailio/tls/$DOMAIN-kamailio1_cert.pem
    cat demoCA/cacert.pem >> /etc/kamailio/tls/$DOMAIN-calist.pem
    cp kamailio1_cert_req.pem /etc/kamailio/tls/$DOMAIN-kamailio1_cert_req.pem
    cp /etc/ssl/ca/privkey.pem /etc/kamailio/tls/$DOMAIN-privkey.pem
    ```

1. update `kamailio.cfg` and `tls.cfg`

    ```bash
    # edit kamailio.cfg adding the following lines
    modparam("tls", "server_name", "your.domain.com")

    # edit tls.cfg adding the following lines
    [server:any]
    method = TLSv1.2+
    verify_certificate = no
    require_certificate = no
    private_key = /etc/kamailio/tls/your.domain.com-privkey.pem
    certificate = /etc/kamailio/tls/your.domain.com-kamailio1_cert.pem
    ca_list = /etc/kamailio/tls/your.domain.com.io-calist.pem
    server_name = your.domain.com
    server_id = your.domain.com
    ```

1. give to customers the certificate

    Customer has to set this certificate in their client: `your.domain.com.io-calist.pem`
    *F.e.* using `Linphone` on MacOS using this command:

    ```bash
    cat your.domain.com.io-calist.pem >> /Applications/Linphone.app/Contents/Resources/share/linphone/rootca.pem
    ```
    
    *F.e.* using `Telephone` on MacOS using this command:

    ```bash
    cat your.domain.com.io-calist.pem >> /Applications/Telephone.app/Contents/Resources/PublicCAs.pem
    ```
