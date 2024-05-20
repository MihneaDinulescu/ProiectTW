window.addEventListener("load" , function(){
   
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
                vCal = inpGradUzura.split(":")
                minGradUzura = parseInt(vCal[0])
                maxGradUzura = parseInt(vCal[1])
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
                    return semn * nume_a.localeCompare(nume_b, undefined, { sensitivity: 'accent' }); 
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
        

    })
