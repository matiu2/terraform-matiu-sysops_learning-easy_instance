variable "ssh_public_key_file" {
  description = "The path to your ssh public key file"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

variable "user_data" {
  description = "user_data to send to the instance"
  type        = string
  default     = null
}

variable "ingress_ports" {
  description = "Which ports should incoming traffic be allowed in on for the instance. Note all traffic will be restricted to your local IP anyway. Nothing will be public."
  type        = list(number)
  default     = [22, 80, 443]
}

variable "egress_ports" {
  description = "Which ports should outgoing traffic be allowed on to the rest of the internet?"
  type        = list(number)
  default     = [80, 443]
}

variable "dns_prefix" {
  description = "DNS name XXX.matiu.dev that you want for this instance"
  type        = string
  default     = "test"
}
