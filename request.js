function request(param, getData){
    //console.log(param);
    var url = "https://jsonplaceholder.typicode.com/" + getData;
    axios.get(url , {
        params: param
    })
    .then(function (response){
        switch (getData){
            case 'posts':
            case 'comments':
                exportSql(response.data, getData);
                break;
            default:
                exportCsv(response.data);
        }

    })
    .catch(function (error){
        console.log(error);
    })
    .finally(function (){

    });
}
