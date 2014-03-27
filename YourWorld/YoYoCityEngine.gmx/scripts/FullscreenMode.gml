///FullscreenMode(in_out)
{
    // alredy in the correct mode?
    if( window_get_fullscreen() == argument0 ) return -1;      
    
    if( argument0 )
    {
        // go INTO fullscreen mode.
        window_set_size(display_get_width(), display_get_height() );
        view_wport[0]=display_get_width();
        view_hport[0]=display_get_height();
        view_wview[0]=display_get_width();
        view_hview[0]=display_get_height();
        window_set_fullscreen(true);
    }else{
        window_set_fullscreen(false);
        var w=1280;
        var h=720;
        window_set_size(w,h);
        view_wport[0]=w;
        view_hport[0]=h;
        view_wview[0]=w;
        view_hview[0]=h;
    }
}
