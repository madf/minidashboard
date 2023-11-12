function calcCPUUsage(old) {
  const line = readFile("/proc/stat").split("\n")[0]
  const diffs = {
    user:
    nice:
    system:
    idle:
    iowait:
  }
}

function calcMemUsage() {
  return 71
}

function composeItem(i) {
  return i.name + " " + window[i.source]() + i.unit
}

function composeGroup(g) {
  return g.map(i => composeItem(i)).join(", ")
}

function readFile(p) {
  var xhr = new XMLHttpRequest()
  xhr.open("GET", p, false)
  xhr.send(null)
  return xhr.responseText
}
