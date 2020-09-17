$('.minus-btn').on('click', function(e) {
    e.preventDefault();
    let $this = $(this);
    let $input = $this.closest('div').find('input');
    let value = parseInt($input.val());

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

    if (value >= 1) {
        value += 1;
        const totalPrice = document.getElementById('price-total');
        const unitPrice = parseInt(document.getElementById('price-item').innerText.split("£")[1])
        const total = value * unitPrice
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


