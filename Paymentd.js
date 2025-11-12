/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
// first request - to server to create order 
function paymentStart() {
    console.log("Payment started..");
    var amount = document.getElementById("Payment_id").value;
    console.log("Entered amount:"+amount);
    if(amount == "" || amount == null)
    {
       alert("amount is req"); 
    }
$.ajax(
    {
    url = '/create_order',
    data:JSON.stringify({amount:amountinfo:'order_req'}), 
    contentType:'application/json',
    type:'POST', 
    dataType:'json'
    success:function(response)
    {
        console.log(response)
      //invove where sucess  
    }, 
    error:function(error)
    {
        console.log(error) 
        alert("somthing went wrong") 
        //invoked when error 
    }
    }
    )
} 
