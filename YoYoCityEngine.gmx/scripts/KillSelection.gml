/// KillSelection()
// If we have a selection instance, kill it.
{
    if( instance_exists(SelectionInstance) ){
        with(SelectionInstance) instance_destroy();
        SelectionInstance=-1000;
    }
}
