package k8shaslimits

test_input_no_violations_int {
    input := {"review": review([ctr("a", 10, 20)])}
    results := violation with input as input
    count(results) == 0
}

test_input_violation_int {
    input := {"review": review([ctr_no_limits("b", 10, 20)])}
    results := violation with input as input
    count(results) == 1
}

review(containers) = output {
  output = {
    "object": {
      "metadata": {
        "name": "nginx",
      },
      "spec": {"containers": containers}
    }
  }
}

init_review(containers) = output {
  output = {
    "object": {
      "metadata": {
        "name": "nginx",
      },
      "spec": {"initContainers": containers}
    }
  }
}

ctr(name, mem, cpu) = out {
  out = {"name": name, "image": "nginx", "resources": {"limits": {"memory": mem, "cpu": cpu}}}
}

ctr_no_limits(name, mem, cpu) = out {
  out = {"name": name, "image": "nginx", "resources": {"requests": {"memory": mem, "cpu": cpu}}}
}