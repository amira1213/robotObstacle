
ArrayList <Case>Parcours=new ArrayList();
ArrayList <Case>resultat=new ArrayList();
ArrayList <Case>marquage=new ArrayList();
boolean found=false;
 Case x;
 Case objectif=new Case();
 boolean refaire=true,rf=true;

 int z=-1,nbCellules=0,c=0;

PImage img;
int tour;
int i,j, w, h,xMove=1,yMove=1,taille=0;
float r,g,b;
int [][]obst={{1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
        {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
        {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
        {1,0,0,0,0,0,0,0,0,0,1,1,0,0,0,1},
        {1,1,0,0,1,0,0,1,0,0,0,0,0,0,0,1},
        {1,0,0,0,1,0,0,1,1,0,0,0,0,0,0,1},
        {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
        {1,0,0,0,0,3,0,0,0,0,0,0,1,0,0,1},
        {1,0,0,0,1,0,0,0,0,0,0,0,1,0,0,1},
        {1,0,0,0,0,0,1,1,0,0,0,0,0,0,0,1},
        {1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,1},
        {1,0,0,0,0,1,0,0,0,0,0,0,0,1,1,1},
        {1,0,0,0,0,2,0,0,1,0,0,0,0,0,0,1},
        {1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,1},
        {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
        {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1}}; 

void setup() {
  frameRate(7);
  size(512, 512);
  img = loadImage("grille.bmp");
 w=img.width;
 h=img.height;
 tour=0;
 loadPixels();

  img.loadPixels();
}

void draw() {
for (int x = 0; x < w; x++ ) {
    for (int y = 0; y < h; y++ ) {

     int loc = x + y*w;
      int stepx=w/16;
      int stepy=h/16;
      i= y/stepy; j=x/stepx;
      int val=obst[i][j];
      switch (val)
      {
        case 0: r= 0; g=0; b=0; break;
        case 1: r= 0; g=0; b=255; break;
        case 2: r= 255; g=0; b=0; break;
        case 3: r= 0; g=255; b=0; break;
       case 5: r=255; g=255; b=255;
        
      }      
      
      color c = color(r, g, b);
      pixels[loc]=c;    
      
    }  
    

  }
 rechercheLargeur();
  if(z==-1)
      {   z=1;}
  updatePixels(); 

} //fin draw
  
 void rechercheLargeur()
  {    
    int i=0; boolean trouver=false;
     if (refaire)
     {while ((i<16) && (trouver==false))  //rechercher la pos du robot initiale 
    {  j=0;
       while ((j<16) && (trouver==false))
       { 
          if(obst[i][j]==2)
          { trouver=true;  x=new Case(i,j,-1,-1,2);
             z=0; }
         j++;
          }
       i++;
    }  marquage.add(x);  } //pos initiale  du robot trouvée
      
//ci bienne jusque ici
    
  //recherche de l'objectif 
  if (Parcours.size()>1 && rf==true)
{obst[Parcours.get(xMove).xPos][Parcours.get(xMove).yPos]=2; //obst[Parcours.get(xMove-1).xPos][Parcours.get(xMove-1).yPos]=0; 
nbCellules++;
    if((found==true))
    {  if (obst[objectif.xPos][objectif.yPos]!=3)
            {rf=false;  print("le nombre de déplacement est= ",nbCellules," cellules"); }}
      xMove++;
     
}
 
 while ((marquage.size() >0) && (found==false))
  {    ArrayList <Case>Voisins=new ArrayList();
       x=marquage.get(0);
       marquage.remove(0);
       Parcours.add(x);
                     
             if (x.xPos>=1)  
              Voisins.add(new Case((x.xPos)-1,x.yPos,x.xPos,x.yPos,obst[(x.xPos)-1][x.yPos]));  
             if (x.xPos<15) 
              Voisins.add(new Case((x.xPos)+1,x.yPos,x.xPos,x.yPos,obst[(x.xPos)+1][x.yPos]));           
                if (x.yPos<15) 
              Voisins.add(new Case(x.xPos,(x.yPos)+1,x.xPos,x.yPos,obst[x.xPos][(x.yPos)+1]));       
              if (x.yPos>=1)  
             Voisins.add(new Case(x.xPos,(x.yPos)-1,x.xPos,x.yPos,obst[x.xPos][(x.yPos)-1]));            
              if (x.xPos>=1) 
             Voisins.add(new Case((x.xPos)-1,x.yPos,x.xPos,x.yPos,obst[(x.xPos)-1][x.yPos])); 
               
         int  nb=0;  Case Y;
       while ((nb<Voisins.size()) && found==false)
       {     Y=new Case(Voisins.get(nb).xPos,Voisins.get(nb).yPos,Voisins.get(nb).xPere,Voisins.get(nb).yPere,Voisins.get(nb).valeur);
            if(Voisins.get(nb).valeur!=1) //si ce n'est pas un obstacle
            {  
               if (! exists(Voisins.get(nb).xPos,Voisins.get(nb).yPos) & ! exists1(Voisins.get(nb).xPos,Voisins.get(nb).yPos))
               {                     
                    marquage.add(Y); 

                    if (Voisins.get(nb).valeur==3)
                     {  found=true;
                          Parcours.add(Y);
                             
                     }
               }
            
            } 
          
                
         nb++;
         
       }
            
  }
  objectif=new Case(Parcours.get(Parcours.size()-1).xPos,Parcours.get(Parcours.size()-1).yPos,Parcours.get(Parcours.size()-1).xPere,Parcours.get(Parcours.size()-1).yPere,Parcours.get(Parcours.size()-1).valeur);
   resultat.add(objectif);   
 while(!robot(  resultat.get(resultat.size()-1))) //s'erreter une fois remonté jusqu'au robot
   {   resultat.add(Pere(resultat.get(resultat.size()-1)));
     
      
   }

 if( (obst[objectif.xPos][objectif.yPos]!=3))
 {for (int s=resultat.size()-1; s>0; s--) //chemin direct 
   {        
        obst[resultat.get(s).xPos][resultat.get(s).yPos]=5;
       
       
    } }
           
         
       
     }

  Case Pere(Case x)
  {   Case papa=new Case(); boolean find=false; int comp=0; 
       while((comp<Parcours.size()) && (find==false))
       {      
        if ((x.xPere==Parcours.get(comp).xPos) && (x.yPere==Parcours.get(comp).yPos))
         {find=true;
             papa=new Case(Parcours.get(comp).xPos,Parcours.get(comp).yPos,Parcours.get(comp).xPere,Parcours.get(comp).yPere,Parcours.get(comp).valeur);
              
         }
         comp++;
       }
       
    return papa;
  }
 
 boolean exists(int  valeur1,int valeur2) //si l'element à dejè été marqué (visité)
 {
     int cpt=0; boolean b=false;
     
     while((cpt<marquage.size()) && (b==false))
     {
        if (marquage.get(cpt).xPos==valeur1 && marquage.get(cpt).yPos==valeur2)
        b=true;
       cpt++;
     }
   
   
   return b;
 }
 
  
 boolean exists1(int  valeur1,int valeur2) //si l'element à dejè été marqué (visité)
 {
     int cpt=0; boolean b=false;
     
     while((cpt<Parcours.size()) && (b==false))
     {
        if (Parcours.get(cpt).xPos==valeur1 && Parcours.get(cpt).yPos==valeur2)
        b=true;
       cpt++;
     }
   
   
   return b;
 }
 boolean robot(Case x) //si on est remonté jusqu'en haut 
 { 
   if((x.xPere==-1) && (x.yPere==-1))
   return true;
   else return false;
 }
 
 
 
 
 
public class Case{   //classe case
int xPos,yPos,xPere,yPere,valeur;

Case(int a,int b, int c, int d ,int e) //constructeur de case
{
   xPos=a;
   yPos=b;
   xPere=c;
   yPere=d;
   valeur=e;
}
Case(){      }
   
}
public class Deplacement{
  int iP,jP; 
  boolean parcouru;
  Deplacement (int i,int j,boolean b)
  {   iP=i; jP=j;
       parcouru=b;
    
    
  }
}