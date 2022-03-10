package k8shaslimits

import data.lib.exempt_container.is_exempt

has_key(x, k) { _ = x[k] }

violation[{"msg": msg}] {
  general_violation[{"msg": msg, "field": "containers"}]
}

general_violation[{"msg": msg, "field": field}] {
  container := input.review.object.spec[field][_]
  not has_key(container.resources, "limits")
  msg := sprintf("container <%v> has not limits set", [container.name])
}



