# cryptor_app

Windows app for crypting data.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

MSIX packaging
MSIX, the new Windows application package format, provides a modern packaging format and installer. This format can either be used to ship applications to the Microsoft Store on Windows, or you can distribute app installers directly.

The easiest way to create an MSIX distribution for a Flutter project is to use the msix pub package. For an example of using the msix package from a Flutter desktop app, see the Desktop Photo Search sample.

Create a self-signed .pfx certificate for local testing
For private deployment and testing with the help of the MSIX installer, you need to give your application a digital signature in the form of a .pfx certificate.

For deployment through the Windows Store, generating a .pfx certificate is not required. The Windows Store handles creation and management of certificates for applications distributed through its store.

Distributing your application by self hosting it on a website requires a certificate signed by a Certificate Authority known to Windows.

Use the following instructions to generate a self-signed .pfx certificate.

If you haven’t already, download the OpenSSL toolkit to generate your certificates.
Go to where you installed OpenSSL, for example, C:\Program Files\OpenSSL-Win64\bin.
Set an environment variable so that you can access OpenSSL from anywhere:
"C:\Program Files\OpenSSL-Win64\bin"
Generate a private key as follows:
openssl genrsa -out mykeyname.key 2048
Generate a certificate signing request (CSR) file using the private key:
openssl req -new -key mykeyname.key -out mycsrname.csr
Generate the signed certificate (CRT) file using the private key and CSR file:
openssl x509 -in mycsrname.csr -out mycrtname.crt -req -signkey mykeyname.key -days 10000
Generate the .pfx file using the private key and CRT file:
openssl pkcs12 -export -out CERTIFICATE.pfx -inkey mykeyname.key -in mycrtname.crt
Install the .pfx certificate first on the local machine in Certificate store as Trusted Root Certification Authorities before installing the app.
