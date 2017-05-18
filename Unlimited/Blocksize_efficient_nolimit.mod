

         MODEL DEFAULTS
         --------------

Model Name:         Blocksize_efficient_nolimit.mod
Model Description:  
Output File:        untitled.out
Output Plot Style:  NOAUTO_FIT
Run Mode:           HI_SPEED
Trace Vars:         T,B,TOTALBAT,NB,NEXTDEL,D,R,C
Random Number Seed: 12345
Initial Values:     
Ending Condition:   STOP_ON_TIME
Ending Time:        1576800.000
Trace Events:       Init,Trace,Half
Hide Edges:         



         STATE VARIABLES
         ---------------

     State Variable #1
Name:          ENT
Description:   
Type:          INTEGER
Size:          15

     State Variable #2
Name:          RNK
Description:   
Type:          INTEGER
Size:          10000

     State Variable #3
Name:          T
Description:   Tx memory pool queue size
Type:          INTEGER
Size:          1

     State Variable #4
Name:          B
Description:   Blockchain size
Type:          REAL
Size:          1

     State Variable #5
Name:          M
Description:   Maximum block size capacity
Type:          REAL
Size:          1

     State Variable #6
Name:          TOTALBAT
Description:   Total transactions to fit in current block
Type:          INTEGER
Size:          1

     State Variable #7
Name:          NB
Description:   Size of newly found/mined block
Type:          REAL
Size:          1

     State Variable #8
Name:          NEXTDEL
Description:   Delay until next block is found in minutes
Type:          REAL
Size:          1

     State Variable #9
Name:          U
Description:   Random number
Type:          REAL
Size:          1

     State Variable #10
Name:          D
Description:   Last time mem pool was less than 100000
Type:          REAL
Size:          1

     State Variable #11
Name:          R
Description:   Revenue in BTC per block
Type:          REAL
Size:          1

     State Variable #12
Name:          C
Description:   Current block reward
Type:          REAL
Size:          1



          VERTICES
          --------

     Vertex #1
Name:             Init
Description:      Initialize variables. Set mem pool to 1000, blockchain size to 110,000 MB, define M, capacity at unlimited, Block reward of 12.5 BTC
State Changes:    T=1000,B=110000,M=100000000,C=12.5
Parameter(s):     
Bitmap(Inactive): 
Bitmap(Active):   
Use Flowchart Shapes:   0
Use Opaque Bitmaps:   0
Location:         X:  0.54;  Y:  2.05;  Z: -1.00;
Local Trace:      
Trace Location:   Bottom

     Vertex #2
Name:             TX_Made
Description:      Increase TX Pool T
State Changes:    T=T+173+.000132*CLK
Parameter(s):     
Bitmap(Inactive): 
Bitmap(Active):   
Use Flowchart Shapes:   0
Use Opaque Bitmaps:   0
Location:         X:  2.01;  Y:  2.25;  Z: -1.00;
Local Trace:      
Trace Location:   Bottom

     Vertex #3
Name:             Block
Description:      Block is found. Calculate size of block as NB in bytes. Calculate transaction batch size as TOTALBAT. Calculate new size of blockchain in Mb. Remove TOTALBAT from mem pool T, Calculate delay until next block found. Record time if mem pool is less than 100000.
State Changes:    NB=MIN{T*500;M*0.95},TOTALBAT=NB/500,B=B+NB/1000000,NEXTDEL=10*(-LN{RND}),T=MAX{T-TOTALBAT;0},D=(T<100000)*CLK,R=TOTALBAT*.000273+C
Parameter(s):     
Bitmap(Inactive): 
Bitmap(Active):   
Use Flowchart Shapes:   0
Use Opaque Bitmaps:   0
Location:         X:  2.02;  Y:  1.54;  Z: -1.00;
Local Trace:      
Trace Location:   Bottom

     Vertex #4
Name:             Trace
Description:      Simple trace event
State Changes:    
Parameter(s):     
Bitmap(Inactive): 
Bitmap(Active):   
Use Flowchart Shapes:   0
Use Opaque Bitmaps:   0
Location:         X:  2.57;  Y:  1.90;  Z: -1.00;
Local Trace:      
Trace Location:   Bottom

     Vertex #5
Name:             Half
Description:      Block size halving 1
State Changes:    C=0.5*C
Parameter(s):     
Bitmap(Inactive): 
Bitmap(Active):   
Use Flowchart Shapes:   0
Use Opaque Bitmaps:   0
Location:         X:  2.02;  Y:  1.02;  Z: -1.00;
Local Trace:      
Trace Location:   Bottom



          EDGES
          -----


     Graphics Edge #1

  Sub-Edge #1
Description:   Block is found as an exponential distribution with mean of 10 minutes
Type:          Scheduling
Origin:        Block
Destination:   Block
Condition:     1==1
Delay:         NEXTDEL
Priority:      5
Attributes:    

     Graphics Edge #2

  Sub-Edge #2
Description:   Next transaction set to be made in 1 minutes
Type:          Scheduling
Origin:        TX_Made
Destination:   TX_Made
Condition:     1==1
Delay:         1
Priority:      5
Attributes:    

     Graphics Edge #3

  Sub-Edge #3
Description:   Make first transaction
Type:          Scheduling
Origin:        Init
Destination:   TX_Made
Condition:     1==1
Delay:         0
Priority:      5
Attributes:    

     Graphics Edge #4

  Sub-Edge #4
Description:   Mine first block after 10 minutes
Type:          Scheduling
Origin:        Init
Destination:   Block
Condition:     1==1
Delay:         10
Priority:      5
Attributes:    

     Graphics Edge #5

  Sub-Edge #5
Description:   Trace every 24 hours
Type:          Scheduling
Origin:        Trace
Destination:   Trace
Condition:     1==1
Delay:         1440
Priority:      5
Attributes:    

     Graphics Edge #6

  Sub-Edge #6
Description:   
Type:          Scheduling
Origin:        Init
Destination:   Trace
Condition:     1==1
Delay:         0
Priority:      5
Attributes:    

     Graphics Edge #7

  Sub-Edge #7
Description:   Next halving after 163000 blocks
Type:          Scheduling
Origin:        Init
Destination:   Half
Condition:     1==1
Delay:         1630000
Priority:      5
Attributes:    

     Graphics Edge #8

  Sub-Edge #8
Description:   Next occurs every 210000 blocks
Type:          Scheduling
Origin:        Half
Destination:   Half
Condition:     1==1
Delay:         2100000
Priority:      5
Attributes:    

