provider "aws" {
  region = "eu-central-1"
  default_tags {
    tags = {
      Environment = "Test"
    }
  }
}

run "invalid_identifier" {
  command = plan

  variables {
    identifier = "a"
    partition_key = {
      name = "TestPKey"
      type = "S"
    }
    sort_key = {
      name = "TestSKey"
      type = "S"
    }
  }

  expect_failures = [var.identifier]
}

run "valid_identifier" {
  command = plan

  variables {
    identifier = "abc"
    partition_key = {
      name = "TestPKey"
      type = "S"
    }
    sort_key = {
      name = "TestSKey"
      type = "S"
    }
  }
}
