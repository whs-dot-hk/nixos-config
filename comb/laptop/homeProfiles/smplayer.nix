{
  home.file.".config/smplayer/smplayer.ini".text = ''
    [advanced]
    mplayer_additional_options=--hwdec=nvdec-copy --vo=gpu-next
    use_mplayer_window=true
    [default_gui]
    ; Display remaining time instead of total time
    actions\floating_control\1=play_or_pause, stop, separator, rewind1, current_timelabel_action, timeslider_action, remaining_timelabel_action, forward1, separator, fullscreen, mute, volumeslider_action
    [gui]
    mouse_left_click_function=play_or_pause
  '';
}
