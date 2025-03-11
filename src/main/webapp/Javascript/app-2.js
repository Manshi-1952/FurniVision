
$(document).ready(function() {
    $(".add-cart-btn").on("click", function() {
        var form = $(this).closest("form");
        var productId = form.find("input[name='product_id']").val();
        var userId = form.find("input[name='user_id']").val();
        var quantity = form.find("input[name='quantity']").val();

        $.ajax({
            url: "cart",
            type: "POST",
            dataType: "json",
            data: {
                product_id: productId,
                user_id: userId,
                quantity: quantity
            },
            success: function(response) {
                console.log("Response:", response);
                var btn = form.find(".add-cart-btn");

                if (response.success) {
                    if (response.isInCart) {
                        btn.text("Already in Cart").prop("disabled", true);
                    } else {
                        btn.text("Added to Cart").prop("disabled", true);
                    }
                } else {
                    alert("Error: " + response.message);
                }
            },
            error: function(xhr) {
                console.error("AJAX Error:", xhr.responseText);
                alert("An error occurred: " + xhr.responseText);
            }
        });
    });
});
