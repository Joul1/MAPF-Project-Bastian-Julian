#!/bin/bash


echo "=> solve via encoding..."
clingo "encoding 2.0.lp" InstanceMIF.lp --outf=1 --verbose=0 > PlanMIF.lp
sed -i '1d' PlanMIF.lp

echo "=> convert problem instance from mif to m..."
clingo mif_to_asprilo.lp InstanceMIF.lp --outf=1 --verbose=0 > InstanceM.lp
sed -i '1d' InstanceM.lp

echo "=> convert plan from mif to m..."
clingo mif_to_asprilo.lp PlanMIF.lp --outf=1 --verbose=0 > PlanM.lp
sed -i '1d' PlanM.lp

echo "=> visualize InstanceM.lp & PlanM.lp..."
viz 