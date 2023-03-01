# MAPF-Project-Bastian-Julian

## Members
Bastian Franke

Julian Bruns

This repository contains an ASP encoding for the MAPF project and a shell scripts that helps to run the encoding on test instances. 

%encoding.lp

The ASP encoding is pretty straight forward. It starts by hardcoding a timelimit. This is very important because else the grounder would ground infinite move/4 atoms. 
The start position and agents are given by the test instance, so we can use both to create all possible first move actions for every agents at timestep 1 (line 24). Note here that we implemented the wait action in a seperate rule (line 26). Because the rule in line 24 depends on not having a wait action, we created a choice between the rule in line 24 and 26. From the first actions we can now iteratively build all move and wait actions for all agents in all timesteps from 2 to the set timelimit (line 31/33).
At this point in the programm, we have all possible paths in the given timelimit starting at the starting locations. All thats left is to find and delete all answer sets with invalid paths. We start by removing sets where a path is going though a wall (line 38/40). Then we ensure that we only keep the answer sets where every agent has reached it's goal at the last timestep (line 43). After that we eliminate answer sets where a vertex ord swap conflict occurs (line 47/50). 
At the end we build the path/3 and plan/3 atoms with the right syntax for the output and the respective #show statements (line 55-64).

%visualize.sh

Our ASP encoding only works with instances in the Asprilo MIF format. We created this shell script to use the visualize tool from Asprilo, that helps to verify the correctness of a solution. As the visualize tool works with solutions in the M format, one need to convert the MIF instance and the MIF solution to M. This script uses the ASP encoding under the name "encoding 2.0.lp" with a MAPF MIF instance of the name "InstanceMIF.lp", converts the instance and the outcoming solution to M into the files "InstanceM.lp" and "PlanM.lp" and opens the visualize tool.
To use our script one needs to run it in the same directory as a MAPF ASP encoding with the name "encoding 2.0.lp" and a MAPF ASP MIF instance with the name "InstanceMIF.lp". Then when the visualize tool pops of, one needs to select the newly created files in the M format in the respective toolbars.
