variable "name" {
  description = "Name to be used on all resources as prefix"
  type        = string
}

variable "product_code" {
  description = "Unique identifier across the whole DEEP platform"
}

variable "baseline_workspace_name" {
  description = "Baseline workspace to read the outputs"
}
