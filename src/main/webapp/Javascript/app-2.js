$(document).ready(function() {
    $(".add-cart-btn").on("click", function() {
        var form = $(this).closest("form");
        var productId = form.find("input[name='product_id']").val();
        var userId = form.find("input[name='user_id']").val();
        var quantity = form.find("input[name='quantity']").val();
        var price = form.find("input[name='price']").val();

        // AJAX request to add the item to the cart
        $.ajax({
            url: "cart", // The servlet URL
            type: "POST",
            data: {
                product_id: productId,
                user_id: userId,
                quantity: quantity,
                price: price
            },
            success: function(response) {
                // Update button text after successful addition to cart
                if (response === "success") {
                    form.find(".add-cart-btn").text("Added to Cart").prop("disabled", true);
                } else {
                    alert("There was an error adding the product to the cart.");
                }
            },
            error: function() {
                alert("An error occurred while adding to the cart.");
            }
        });
    });
});
