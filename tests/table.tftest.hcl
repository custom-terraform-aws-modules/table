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
    hash_key = {
      name = "TestPKey"
      type = "S"
    }
  }

  expect_failures = [var.identifier]
}

run "valid_identifier" {
  command = plan

  variables {
    identifier = "abc"
    hash_key = {
      name = "TestPKey"
      type = "S"
    }
  }
}

run "invalid_stream_view" {
  command = plan

  variables {
    identifier = "abc"
    hash_key = {
      name = "TestPKey"
      type = "S"
    }
    stream_view = "TEST_ONLY"
  }

  expect_failures = [var.stream_view]
}

run "valid_stream_view" {
  command = plan

  variables {
    identifier = "abc"
    hash_key = {
      name = "TestPKey"
      type = "S"
    }
    stream_view = "KEYS_ONLY"
  }
}
