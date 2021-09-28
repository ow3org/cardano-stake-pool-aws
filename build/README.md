# Cardano Stake Pool - Build Process

After we provision a new Ubuntu machine, we execute the `build_node.sh`-file which then executes all 9 steps that are stored within this folder.

We logically split up the steps required to build a Cardano node and their names explain what each step is responsible for doing.

## Portability

It's incredibly easy to port this outside of AWS, or even out of the Ubuntu environment. There is nothing in particular constraining it to this ecosystem and soon we likely will support other environments.

We would love to hear feedback!
