# Automate Infrastructure on Any Cloud - TerraForm

## Introduce

official home page : https://www.terraform.io/

### Adopt
Compose infrastructure as code in a Terraform file using HCL to provision resources from any infrastructure provider.

### Installation
* https://learn.hashicorp.com/tutorials/terraform/install-cli
* [poser shell install script](https://github.com/LowyShin/KnowledgeBase/blob/master/wiki/terraform/terraforminstall.ps1)

### Build
Infrastructure automation workflow used to compose, collaborate, reuse, and provision infrastructure as code across IT operations and teams of developers.

### Standardize
Infrastructure automation workflow featuring security, compliance, and cost management capabilities while using access controls, policy enforcement, and audit.

### Innovate
Infrastructure automation workflow extending to all teams in the organization with self-service infrastructure as code and integrates with VCS, ITSM, CI/CD.

## Quick Start

* [Understand Terraform (infra-as-code) in 5 minutes](https://www.jesuisundev.com/en/understand-terraform-infra-as-code-in-5-minutes/)
  * [(ja)5分で分かるTerraform（Infrastructure as Code）](https://www.lac.co.jp/lacwatch/service/20200903_002270.html)

## Trouble Shooting

- error occured \u0081 character parsing error on authentication JSON data parsing using `terraform plan`
    - 日本語表記のAzure登録情報がterraformから読み取った場合\u0081(何も表示されない文字なので見つからない)が含まれていたらエラーになる。
        - Azureのアカウント情報を全て英語に入れて新規作成すると解決。
