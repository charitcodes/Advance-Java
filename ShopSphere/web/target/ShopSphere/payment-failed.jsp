<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <title>ShopSphere - Payment Failed</title>

    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">

</head>

<body>

<nav class="navbar navbar-dark bg-dark">

    <div class="container">

        <a class="navbar-brand"
           href="${pageContext.request.contextPath}/products">

            ShopSphere

        </a>

    </div>

</nav>


<div class="container mt-5">

    <div class="row justify-content-center">

        <div class="col-md-6">

            <div class="card shadow text-center">

                <div class="card-body p-5">

                    <h1 class="text-danger mb-3">
                        ✕
                    </h1>

                    <h2 class="text-danger">
                        Payment Failed
                    </h2>

                    <p class="mt-3">
                        Unfortunately, your payment could not be completed.
                    </p>

                    <div class="mt-4">

                        <a href="${pageContext.request.contextPath}/orders"
                           class="btn btn-primary me-2">

                            My Orders

                        </a>

                        <a href="${pageContext.request.contextPath}/products"
                           class="btn btn-secondary">

                            Continue Shopping

                        </a>

                    </div>

                </div>

            </div>

        </div>

    </div>

</div>

</body>

</html>