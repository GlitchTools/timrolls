class Particle{
	int finger_which;
//	color clr;
	PVector pt;

	int lifespan = (int)random(250,1000);
        int rotation = (int)random(-180,180);

//	int minScale = 1;
//	int maxScale = 500;
	int scaleNum = 1;

        int _arrayPos;

	PVector location;
	PVector velocity;
	PVector acceleration;
       
 
        PImage whichArt;

	float vx, vy, dx, dy;
	float spring = 1;
	float ease =0.0001;
        

	Particle(int i, int _finger_which, PVector _pt, int arrayPos ) {
		finger_which = _finger_which;
		_arrayPos = arrayPos;
		pt = _pt;

		vx = 0;
		vy = 0;
		dx = 0;
		dy = 0;
                
             whichArt = art[ (int)random(artnum) ];
		location = pt.get();
		velocity = new PVector( random(-0.005,0.005), random(-0.005,0.005), random(1) );
		acceleration = new PVector(random(-0.001,0.001), random(-0.001,0.001));
              
                
	}

	void run() {
                if(lifespan<200){
                  if ( lifespan!=0 ) shrink();
               }
          
                velocity.add(acceleration);
                location.add(velocity);
               

		dx = pt.x - (width/2);
		vx += (pt.x - (width/2)) * ease;
		vx *= spring;
		if(abs(dx)>1) location.x += vx;

		dy = pt.y - (height/2);
		vy += (pt.y - (height/2)) * ease;
		vy *= spring;
		if(abs(dy)>1) location.y += vy;

                //iterate over colors, based on particles start point
                _arrayPos++;
                 if(_arrayPos >= arrayMax){
                    _arrayPos=0;
                  }

		container.beginDraw();

//		maxScale -= scaleNum;
//		if (maxScale<=minScale) maxScale = minScale;

//	        container.stroke(#000000); 
//                container.fill(#e7e7e7);

		container.pushMatrix();
                        container.translate(location.x, location.y, map(location.z,0,100,50,-1000) );
//			container.rotate( radians( (map(location.z,0,100,-900,900)/2)  ) );
              
			container.rotate( radians( map(lifespan,-900,900,0,rotation) + (lifespan) ) );
                        
                        color c = arrayColor[ arrayInt[_arrayPos] ];
                        container.tint( c );
			container.image(whichArt,0,0);
		container.popMatrix();

		container.endDraw();

		if (lifespan>0) lifespan--;
              
//                println("lifespan "+lifespan+"   whichArt size "+whichArt.width);
	}

	boolean isDead() {
		return (lifespan==0);
	
     }

     void shrink(){
//          velocity.z += shrink;
            int temp = whichArt.width;
            temp--;
            if(temp<=10){ temp = 10;  lifespan=0;}
            whichArt.resize( temp, temp);   
     }

}
