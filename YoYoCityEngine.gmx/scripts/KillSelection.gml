/// KillSelection()
// If we have a selection instance, kill it.
with(global.Controller)
{
    if( instance_exists(SelectionInstance) ){
        with(SelectionInstance) instance_destroy();
        SelectionInstance=-1000;
    }
}
