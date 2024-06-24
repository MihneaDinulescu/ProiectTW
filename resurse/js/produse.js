window.addEventListener("load" , function(){
    document.getElementById("i_rad4").checked = true;
    document.getElementById("inp-pret").onchange = function(){
        document.getElementById("infoRange").innerHTML = `(${this.value})`
    }


    document.getElementById("filtrare").onclick 
        = function(){
            var input_nume = document.getElementById("inp-nume")
                                     .value
                                     .toLowerCase()
                                     .trim()
            
            var radio_GradUzura = document.getElementsByName("gr_rad")
            let inpGradUzura;
            for(let rad of radio_GradUzura){
                if(rad.checked){
                    inpGradUzura=rad.value
                    break;
                }
            }
            let minGradUzura,maxGradUzura
            if(inpGradUzura !="toate"){
                vGrad = inpGradUzura.split(":")
                minGradUzura = parseInt(vGrad[0])
                maxGradUzura = parseInt(vGrad[1])
            }

            var inp_pret = parseInt(document.getElementById("inp-pret").value);

            var inpMarime=document.getElementById("inp-marime").value.toLowerCase().trim()

            var produse = document.getElementsByClassName("produs")
            for(let produs of produse){

                let val_nume = produs.getElementsByClassName("val-nume")[0].innerHTML
                                                                           .toLowerCase()
                                                                           .trim()

                let val_grad_uzura = parseInt(produs.getElementsByClassName("val-grad_uzura")[0].innerHTML)
                                                                           
                let val_pret = parseFloat(produs.getElementsByClassName("val-pret")[0].innerHTML)
                let cond3= (val_pret > inp_pret)

                let cond1 = val_nume.startsWith(input_nume);

                let cond2 = (inpGradUzura=="toate" || minGradUzura <= val_grad_uzura && val_grad_uzura < maxGradUzura);

                let valMarime = produs.getElementsByClassName("val-marime")[0].innerHTML
                                                                           .toLowerCase()
                                                                           .trim()

               let cond4=(inpMarime==valMarime || inpMarime=="toate")

        

                if(cond1 && cond2 && cond3 && cond4){
                    produs.style.display="block";
                }else{
                    produs.style.display="none";
                }

            }
        }


        document.getElementById("resetare").onclick = function() {
           
            const confirmReset = confirm("Vrei cu adevărat să resetezi filtrele?");
        
           
            if (confirmReset) {
              
                resetFilters();
            }
        }
        
        function resetFilters() {
           
            document.getElementById("inp-nume").value = "";
            document.getElementById("inp-pret").value = document.getElementById("inp-pret").min;
            document.getElementById("inp-marime").value = "toate";
            document.getElementById("i_rad4").checked = true;
        
            var produse = document.getElementsByClassName("produs");
            for (let prod of produse) {
                prod.style.display = "block";
            }
        
        
        }

        function sorteaza(semn) {
            var produse = document.getElementsByClassName("produs");
            var v_produse = Array.from(produse);
            v_produse.sort(function(a, b) {
                let pret_a = parseInt(a.getElementsByClassName("val-pret")[0].innerHTML);
                let pret_b = parseInt(b.getElementsByClassName("val-pret")[0].innerHTML);
                if (pret_a == pret_b) {
                    let nume_a = a.getElementsByClassName("val-nume")[0].innerHTML;
                    let nume_b = b.getElementsByClassName("val-nume")[0].innerHTML;
                    return semn * nume_a.localeCompare(nume_b); 
                }
                return semn * (pret_a - pret_b);
            });
        
            for (let prod of v_produse) {
                prod.parentNode.appendChild(prod);
            }
        }
        
        document.getElementById("sortCrescNume").onclick = function() {
            sorteaza(1);
        };
        
        document.getElementById("sortDescrescNume").onclick = function() {
            sorteaza(-1);
        };
        
        window.onkeydown = function(e) {
            if (e.key == "c" && e.altKey) {
                var suma = 0;
                var produse = document.getElementsByClassName("produs");
                for (let produs of produse) {
                    var stil = getComputedStyle(produs);
                    if (stil.display != "none") {
                        suma += parseFloat(produs.getElementsByClassName("val-pret")[0].innerHTML);
                    }
                }
                if(!document.getElementById("par_suma")){
                let p=document.createElement("p")
                p.innerHTML=suma;
                p.id="par_suma";
                container=document.getElementById("produse")
                container.insertBefore(p,container.children[0])
                setTimeout(function(){
                    var pgf=document.getElementById("par_suma")
                    if(pgf)
                    pgf.remove()
                }, 2000)
            }
        }
        }
        

    // CEL MAI IEFTIN produs


    var products = document.querySelectorAll(".produs");


    var cheapestProducts = {};


    products.forEach(function(product) {

        var category = product.querySelector(".val-gen").textContent;
        var price = parseFloat(product.querySelector(".val-pret").textContent);
        var productName = product.querySelector(".val-nume").textContent;


        if (!(category in cheapestProducts) || price < cheapestProducts[category].price) {

            cheapestProducts[category] = { price: price, productName: productName };
        }
    });


    Object.keys(cheapestProducts).forEach(function(category) {
        var cheapestProduct = cheapestProducts[category];

        var productContainer = Array.from(products).find(function(product) {
            return product.querySelector(".val-nume").textContent === cheapestProduct.productName;
        });
        if (productContainer) {
            var saleTag = document.createElement("span");
            saleTag.classList.add("sale-tag");
            saleTag.textContent = "REDUCERE";
            productContainer.appendChild(saleTag);
        }
    });

    })



/* MODAL  */
document.addEventListener("DOMContentLoaded", function() {
    var modal = document.getElementById("myModal");
    var btns = document.querySelectorAll(".produs");
    var span = document.getElementsByClassName("close")[0];

    btns.forEach(btn => {
        btn.onclick = function() {
            modal.style.display = "block";

            var productDetails = "<h2>" + btn.querySelector(".val-nume").textContent + "</h2>"; 
            productDetails += "<p>" + btn.querySelector(".val-material").textContent + "</p>";
            productDetails += "<p>" + btn.querySelector(".val-grad_uzura").textContent + "</p>";
            productDetails += "<p>" + btn.querySelector(".val-marime").textContent + "</p>";
            productDetails += "<p>" + btn.querySelector(".val-gen").textContent + "</p>";

            document.getElementById("productDetails").innerHTML = productDetails;
        }
    });

    span.onclick = function() {
        modal.style.display = "none";
    }

    window.onclick = function(event) {
        if (event.target == modal) {
            modal.style.display = "none";
        }
    }
});
