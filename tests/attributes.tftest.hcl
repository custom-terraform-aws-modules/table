provider "aws" {
  region = "eu-central-1"
  default_tags {
    tags = {
      Environment = "Test"
    }
  }
}

run "hash_key" {
  command = plan

  variables {
    identifier = "abc"
    hash_key = {
      name = "TestPKey"
      type = "S"
    }
  }

  assert {
    condition     = length(local.attributes) == 1
    error_message = "Unexpected amount of attributes were created"
  }
}

run "hash_and_sort_key" {
  command = plan

  variables {
    identifier = "abc"
    hash_key = {
      name = "TestPKey"
      type = "S"
    }
    sort_key = {
      name = "TestSKey"
      type = "S"
    }
  }

  assert {
    condition     = length(local.attributes) == 2
    error_message = "Unexpected amount of attributes were created"
  }
}

run "single_gsi_hash_key" {
  command = plan

  variables {
    identifier = "abc"
    hash_key = {
      name = "TestPKey"
      type = "S"
    }
    gsi_keys = [{
      hash_key = {
        name = "GSIPKey"
        type = "S"
      }
    }]
  }

  assert {
    condition     = length(local.attributes) == 2
    error_message = "Unexpected amount of attributes were created"
  }
}

run "single_gsi_hash_and_sort_key" {
  command = plan

  variables {
    identifier = "abc"
    hash_key = {
      name = "TestPKey"
      type = "S"
    }
    gsi_keys = [{
      hash_key = {
        name = "GSIPKey"
        type = "S"
      }
      sort_key = {
        name = "GSISKey"
        type = "S"
      }
    }]
  }

  assert {
    condition     = length(local.attributes) == 3
    error_message = "Unexpected amount of attributes were created"
  }
}

run "duplicate_gsi_sort_key" {
  command = plan

  variables {
    identifier = "abc"
    hash_key = {
      name = "TestPKey"
      type = "S"
    }
    gsi_keys = [{
      hash_key = {
        name = "GSIPKey"
        type = "S"
      }
      sort_key = {
        name = "TestPKey"
        type = "S"
      }
    }]
  }

  assert {
    condition     = length(local.attributes) == 2
    error_message = "Unexpected amount of attributes were created"
  }
}

run "multiple_gsi_keys" {
  command = plan

  variables {
    identifier = "abc"
    hash_key = {
      name = "TestPKey"
      type = "S"
    }
    gsi_keys = [{
      hash_key = {
        name = "1GSIPKey"
        type = "S"
      }
      sort_key = {
        name = "1GSISKey"
        type = "S"
      }
      },
      {
        hash_key = {
          name = "2GSIPKey"
          type = "S"
        }
        sort_key = {
          name = "2GSISKey"
          type = "S"
        }
      },
      {
        hash_key = {
          name = "3GSIPKey"
          type = "S"
        }
        sort_key = {
          name = "3GSISKey"
          type = "S"
        }
    }]
  }

  assert {
    condition     = length(local.attributes) == 7
    error_message = "Unexpected amount of attributes were created"
  }
}

run "multiple_duplicate_gsi_keys" {
  command = plan

  variables {
    identifier = "abc"
    hash_key = {
      name = "TestPKey"
      type = "S"
    }
    sort_key = {
      name = "TestSKey"
      type = "S"
    }
    gsi_keys = [{
      hash_key = {
        name = "1GSIPKey"
        type = "S"
      }
      sort_key = {
        name = "TestPKey"
        type = "S"
      }
      },
      {
        hash_key = {
          name = "TestSKey"
          type = "S"
        }
        sort_key = {
          name = "2GSISKey"
          type = "S"
        }
      },
      {
        hash_key = {
          name = "1GSIPKey"
          type = "S"
        }
        sort_key = {
          name = "2GSISKey"
          type = "S"
        }
    }]
  }

  assert {
    condition     = length(local.attributes) == 4
    error_message = "Unexpected amount of attributes were created"
  }
}
