function parseCPUValues(line)
{
  const vals = line.split(/\s+/);
  return {
    user: vals[1],
    nice: vals[2],
    system: vals[3],
    idle: vals[4],
    iowait: vals[5]
  }
}

function calcCPUUsage(old) {
  const line = readFile("/proc/stat").split("\n")[0]
  const values = parseCPUValues(line)
  if (typeof old === "undefined") {
    return {
      values: values,
      usage: 0
    }
  }
  let diffs = {
    user: values.user - old.user,
    nice: values.nice - old.nice,
    system: values.system - old.system,
    idle: values.idle - old.idle,
    iowait: values.iowait - old.iowait
  }
  const sum = diffs.user + diffs.nice +
              diffs.system + diffs.idle +
              diffs.iowait
  const usage = Math.round((diffs.user / sum + diffs.nice / sum + diffs.system / sum) * 100)
  return {
    values: values,
    usage: usage
  }
}

function calcMemUsage() {
  const lines = readFile("/proc/meminfo").split("\n")
  const vals = lines.reduce((a, l) => { const kv = l.split(/\s+/); a[kv[0]] = parseInt(kv[1]); return a; }, {})
  let available = vals["MemAvailable:"]
  if (typeof available === "undefined")
    available = vals["MemFree:"] + vals["Cached:"] + vals["Buffers:"]
  return Math.round(available / vals["MemTotal:"] * 100)
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
