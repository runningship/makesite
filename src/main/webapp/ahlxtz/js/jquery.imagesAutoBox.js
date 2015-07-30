/**
 * 
 * @authors Your Name (you@example.org)
 * @date    2015-07-28 16:21:05
 * @version $Id$
 */

function imgAutoBox(thi) {             
    var Thi=thi,
    bw,bh,w,h,img;
    img = Thi.find("img"); 
     
    w = img.width();
    h = img.height();
    
    sr = img.attr("src")
    /*   alert(sr+","+$w+","+$h)*/
    
    bw= Thi.width();
    bh= Thi.height();
    
    b1 = w/h;
    b2 = bw/bh;
        
    if(b1>b2){
 
        img.css("height","100%");
        $wed = bh*b1;
        img.css("width",$wed+"px");
        fz =(Thi.width()-$wed)/2;
        img.css("margin-left",fz+"px");
     
    }else{
        img.css("width","100%");
        $hed = bw/b1;
        img.css("height",$hed+"px");
        fs =(Thi.height()-$hed)/2;
        img.css("margin-top",fs+"px");
    }              
            
    //console.log(sr+'\nbw:'+bw+'\nbh:'+bh+'\nb1:'+b1+'\nw:'+w+'\nh:'+h+'\nb2:'+b2);
    
};
