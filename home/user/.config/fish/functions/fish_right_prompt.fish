# See "Right prompt options" in README.md for configuration options

function __bobthefish_cmd_duration -S -d 'Show command duration'
    [ "$theme_display_cmd_duration" = "no" ]
    and return

    if [ -z "$CMD_DURATION" -o "$CMD_DURATION" -lt 100 ]
        set_color normal
        set_color -b black white --bold

        echo -ns $__bobthefish_left_arrow_glyph

        return
    end

    if [ "$CMD_DURATION" -lt 5000 ]
        set_color normal
        set_color -b black blue --bold

        echo -ns ' ' $__bobthefish_left_arrow_glyph

        set_color normal
        set_color -b blue black --bold

        echo -ns $CMD_DURATION 'ms'

        set_color normal
        set_color -b blue white --bold

        echo -ns ' ' $__bobthefish_left_arrow_glyph
    else if [ "$CMD_DURATION" -lt 60000 ]
        set_color normal
        set_color -b black green --bold

        echo -ns ' ' $__bobthefish_left_arrow_glyph

        set_color normal
        set_color -b green black --bold

        __bobthefish_pretty_ms $CMD_DURATION s

        set_color normal
        set_color -b green white --bold

        echo -ns ' ' $__bobthefish_left_arrow_glyph
    else if [ "$CMD_DURATION" -lt 3600000 ]
        set_color normal
        set_color -b black yellow --bold

        echo -ns ' ' $__bobthefish_left_arrow_glyph

        set_color normal
        set_color -b yellow black --bold

        __bobthefish_pretty_ms $CMD_DURATION m

        set_color normal
        set_color -b yellow white --bold

        echo -ns ' ' $__bobthefish_left_arrow_glyph
    else
        set_color normal
        set_color -b black red --bold

        echo -ns ' ' $__bobthefish_left_arrow_glyph

        set_color normal
        set_color -b red black --bold

        __bobthefish_pretty_ms $CMD_DURATION h

        set_color normal
        set_color -b red white --bold

        echo -ns ' ' $__bobthefish_left_arrow_glyph
    end
end

function __bobthefish_pretty_ms -S -a ms -a interval -d 'Millisecond formatting for humans'
    set -l interval_ms
    set -l scale 1

    switch $interval
        case s
            set interval_ms 1000
        case m
            set interval_ms 60000
        case h
            set interval_ms 3600000
            set scale 2
    end

    switch $FISH_VERSION
        case 2.0.\* 2.1.\* 2.2.\* 2.3.\*
            # Fish 2.3 and lower doesn't know about the -s argument to math.
            math "scale=$scale;$ms/$interval_ms" | string replace -r '\\.?0*$' $interval
        case 2.\*
            # Fish 2.x always returned a float when given the -s argument.
            math -s$scale "$ms/$interval_ms" | string replace -r '\\.?0*$' $interval
        case \*
            math -s$scale "$ms/$interval_ms"
            echo -ns $interval
    end
end

function __bobthefish_timestamp -S -d 'Show the current timestamp'
    [ "$theme_display_date" = "no" ]
    and return

    set -q theme_date_format
    or set -l theme_date_format "+%c"

    echo -n ' '
    set -q theme_date_timezone
        and env TZ="$theme_date_timezone" date $theme_date_format
        or date $theme_date_format
end

function fish_right_prompt -d 'bobthefish is all about the right prompt'
    set -l __bobthefish_left_arrow_glyph \uE0B2

    __bobthefish_cmd_duration

    set_color normal
    set_color -b white black --bold

    __bobthefish_timestamp

    set_color normal
end