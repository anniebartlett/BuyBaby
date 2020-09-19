
// const minusButtons = document.querySelectorAll('.minus-btn')
// minusButtons.forEach((button) => {
//   button.addEventListener('click', (event) => {
//     console.log(button.dataset.productprice);
//     let Bbvalue = parseInt(document.getElementById('btn-value').value);
//     Btval = Bbvalue -= 1
//     Btval.innerText = `Total: £${Btval}`
//   })
// })


$('.minus-btn').on('click', function(e) {
    e.preventDefault();
    let $this = $(this);
    let $input = $this.closest('div').find('input');
    let value = parseInt($input.val());

//console.log($(this).attr('data-product-price'))
    if (value > 1) {
        value -= 1;
        const totalPrice = document.getElementById('price-total');
        const unitPrice = parseInt(document.getElementById('price-item').innerText.split("£")[1])
        const total = value * unitPrice
        totalPrice.innerText = `Total: £${total}`
    } else {
        value = 1;
    }

  $input.val(value);

});

$('.plus-btn').on('click', function(e) {
    e.preventDefault();
    let $this = $(this);
    let $input = $this.closest('div').find('input');
    let value = parseInt($input.val());
console.log("Good bye!")
    if (value >= 1) {
        value += 1;
        const totalPrice = document.getElementById('price-total');
        const unitPrice = parseInt(document.getElementById('price-item').innerText.split("£")[1])
        const cartCount = parseInt(document.getElementById('cartCount').innerText);
        const total = value * unitPrice


        // unitPrice += value
        // if value > 1 then cartCount += 1
        totalPrice.innerText = `Total: £${total}`
    } else {
        value = 1;
    }

    $input.val(value);
});

// calculatePriceItems = () => {
//   // const priceItem = document.getElementById('price-item').value;
//   const btnValue = document.getElementById('btn-value').value;
//   const quantityBtn = document.querySelectorAll('.plus-btn.minus-btn');
//   quantityBtn.addEventListener('click', () => {
//     priceItem * btnValue;
//   });
// }


