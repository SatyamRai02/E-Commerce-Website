<%@page import="java.util.Map"%>
<%@page import="com.learn.mycart.helper.Helper"%>
<%@page import="java.util.List"%>
<%@page import="com.learn.mycart.entities.Category"%>
<%@page import="com.learn.mycart.dao.CategoryDao"%>
<%@page import="com.learn.mycart.helper.FactoryProvider"%>
<%@page import="com.learn.mycart.entities.User"%>
<%

    User user = (User) session.getAttribute("current-user");

    if (user == null) {

        session.setAttribute("message", "You are not logged in");
        response.sendRedirect("login.jsp");
        return;
    } else {

        if (user.getUserType().equals("normal")) {

            session.setAttribute("message", "You are not Admin");
            response.sendRedirect("login.jsp");
            return;
        }
    }


%>    


<%       CategoryDao cdao = new CategoryDao(FactoryProvider.getFactory());
    List<Category> list = cdao.getCategories();


//getting count

Map<String,Long> m = Helper.getCounts(FactoryProvider.getFactory());

%>







<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Panel</title>

        <%@include file="components/common_css_js.jsp" %>

        <style>
            .admin .card{

                border:1px solid #3f51b5;
            }


            .admin .card :hover{
                background:#e2e2e2;
                cursor:pointer;
            }
        </style>


    </head>
    <body>

        <%@include file="components/navbar.jsp" %>

        <div class="container admin">

            <!--            To print message of addition of category-->
            <div class="container-fluid mt-3">

                <%@include file="components/message.jsp" %>


            </div>



            <div class="row mt-3">

                <div class="col-md-4">

                    <!--                    First box-->
                    <div class="card">

                        <div class="card-body text-center">

                            <div class="container">

                                <img style="max-width: 125px;" class="img-fluid rounded-circle" src="img/man.png" alt="user_icon" >
                            </div>

                            <h1><%= m.get("userCount")%></h1>
                            <h1 class="text-uppercase text-muted">Users</h1>
                        </div>
                    </div>


                </div>
                <div class="col-md-4">
                    <!--                     Second box-->
                    <div class="card">

                        <div class="card-body text-center">

                            <div class="container">

                                <img style="max-width: 125px;" class="img-fluid rounded-circle" src="img/list.png" alt="list_icon" >
                            </div>

                            <h1><%=list.size()%></h1>
                            <h1 class="text-uppercase text-muted">Categories</h1>
                        </div>
                    </div>


                </div>
                <div class="col-md-4">
                    <!--                     Third box-->
                    <div class="card">

                        <div class="card-body text-center">

                            <div class="container">

                                <img style="max-width: 125px;" class="img-fluid rounded-circle" src="img/product.png" alt="product_icon" >
                            </div>

                            <h1><%= m.get("productCount")%></h1>
                            <h1 class="text-uppercase text-muted">Products</h1>
                        </div>
                    </div>


                </div>
            </div>


            <!--            Second row-->

            <div class="row mt-3">

                <div class="col-md-6">

                    <!--                    First box-->
                    <div class="card" data-toggle="modal" data-target="#add-category-modal">

                        <div class="card-body text-center">

                            <div class="container">

                                <img style="max-width: 125px;" class="img-fluid rounded-circle" src="img/keys.png" alt="keys_icon" >
                            </div>

                            <p class="mt-2">Click here to add new category</p>
                            <h1 class="text-uppercase text-muted">Add Category</h1>
                        </div>
                    </div>


                </div>

                <div class="col-md-6">

                    <!--                    Second box-->
                    <div class="card" data-toggle="modal" data-target="#add-product-modal">

                        <div class="card-body text-center">

                            <div class="container">

                                <img style="max-width: 125px;" class="img-fluid rounded-circle" src="img/plus.png" alt="plus_icon" >
                            </div>

                            <p class="mt-2">Click here to add new product</p>
                            <h1 class="text-uppercase text-muted">Add Products</h1>
                        </div>
                    </div>




                </div>







            </div>

        </div>




        <!--        add category model-->

        <!-- Button trigger modal -->


        <!-- Modal -->
        <div class="modal fade" id="add-category-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header custom-bg text-white">
                        <h5 class="modal-title" id="exampleModalLabel">Fill category details</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">

                        <form action="ProductOperationServlet" method="post">

                            <input type="hidden" name="operation" value="addcategory">
                            <div class="form-group">
                                <input type="text" class="form-control" name="catTitle" placeholder="Enter category title" required />
                            </div>

                            <div class="form-group">
                                <textarea style="height:200px;" class="form-control" placeholder="Enter category description" name="catDescription" required></textarea>
                            </div>

                            <div class="container text-center">


                                <button class="btn btn-outline-success">Add Category</button>
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>

                            </div>

                        </form>



                    </div>
                    <div class="modal-footer">


                    </div>
                </div>
            </div>
        </div>



        <!--        end category model-->





        <!--        add product model-->

        <!-- Button trigger modal -->


        <!-- Modal -->
        <div class="modal fade" id="add-product-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header custom-bg text-white">
                        <h5 class="modal-title" id="exampleModalLabel">Product details</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">

                        <form action="ProductOperationServlet" method="post" enctype="multipart/form-data">

                            <input type="hidden" name="operation" value="addproduct"/>

                            <div class="form-group">
                                <input type="text" class="form-control" name="pName" placeholder="Enter Product title" required />
                            </div>

                            <div class="form-group">
                                <textarea style="height:150px;" class="form-control" placeholder="Enter product description" name="pDesc" required></textarea>
                            </div>

                            <div class="form-group">
                                <input type="number" class="form-control" name="pPrice" placeholder="Enter Product Price" required />
                            </div>

                            <div class="form-group">
                                <input type="number" class="form-control" name="pDiscount" placeholder="Enter Product Discount" required />
                            </div>

                            <div class="form-group">
                                <input type="number" class="form-control" name="pQuantity" placeholder="Enter Product Quantity" required />
                            </div>




                            <div class="form-group">
                                <select name="catId" id="" class="form-control">

                                    <%                                         for (Category c : list) {


                                    %>
                                    <option value="<%= c.getCategoryId()%>"><%= c.getCategoryTitle()%></option>



                                    <%     }%>

                                </select>
                            </div>


                            <div class="form-group">

                                <label for="pPic">Select Picture of Product</label>
                                <br>

                                <input type="file" name="pPic" id="pPic" required />


                            </div>










                            <div class="container text-center">


                                <button class="btn btn-outline-success">Add Product</button>
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>

                            </div>

                        </form>



                    </div>
                    <div class="modal-footer">


                    </div>
                </div>
            </div>
        </div>



        <!--        end product model-->


        <%@include file="components/common_modals.jsp" %>@
    </body>
</html>
