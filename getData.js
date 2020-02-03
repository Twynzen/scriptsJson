var dateKey = "date";
var dateValue = randomDate(new Date(2012, 0, 1), new Date());
//Para los csv
function exportCsv(response) {
  var section = document.createElement("section");
  var data = Object.keys(response[0]);
  var field = "";
  data.forEach(keys => {
    if (typeof response[0][keys] != "object") {
      field += (field != "" ? "," : "") + keys;
    }
  });
  var div = document.createElement("div");
  div.textContent = field + "," + dateKey;
  section.append(div);
  response.forEach(object => {
    var text = "";

    data.forEach(keys => {
      if (typeof object[keys] != "object") {
        text += (text != "" ? "," : "") + '"' + object[keys] + '"';
      }
    });
    //console.log(text);
    var div = document.createElement("div");
    div.textContent = text + "," + dateValue;
    section.append(div);
  });
  document.body.append(section);
}
//Para los sql
function exportSql(response, table) {
  var section = document.createElement("section");
  var data = Object.keys(response[0]);
  var sql = "";
  /*data.forEach(keys => {
        if (typeof response[0][keys] != 'object') {
            field += (field != "" ? "," : "") + keys;
        }
    });*/
  var n = response.length - 1;
  response.map((object, index) => {
    sql = `INSERT INTO ${table} (`;
    var field = "";
    var text = "(";
    data.forEach(keys => {
      if (typeof object[keys] != "object") {
        field += (field != "" ? "," : "") + '"' + keys + '"';
        text += (text != "(" ? "," : "") + '"' + object[keys] + '"';
      }
    });
    sql += field + ") VALUES " + text + ")";
    //console.log(sql);
    var div = document.createElement("div");
    div.textContent = sql;
    section.append(div);
  });

  document.body.append(section);
}
//fecha incluida en las tablas
function randomDate(start, end) {
  let d = new Date(
    start.getTime() + Math.random() * (end.getTime() - start.getTime())
  );
  let fecha = d.toLocaleDateString();

  return fecha;
}

console.log(randomDate(new Date(2012, 0, 1), new Date()));
