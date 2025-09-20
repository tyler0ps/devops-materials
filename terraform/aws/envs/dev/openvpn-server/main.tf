module "openvpn_server" {
  source = "../../../modules/openvpn-server"

  public_subnet_id = data.terraform_remote_state.vpc.outputs.aws_subnet_public_zone1_id

  vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id
}