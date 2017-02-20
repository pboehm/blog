+++
title = "Latest Photos on Flickr"
draft = false
layout = "post"
nodate = true
noactions = true
nocomments = true
+++

<style type="text/css" media="all">

    .flickr_image_container {
        margin-bottom: 30px;
        position: relative;
    }

    .flickr_image_container img {
        position: relative;
        left:0;
        top:0;
    }

    .flickr_image_title {
        z-index: 100;
        position: absolute;
        color: rgb(231, 230, 230);
        font-size: 14px;
        left: 0px;
        bottom: 6px;
        padding: 3px 15px;
        margin: 0px !important;

        background: rgba(0, 0, 0, 0.5);
    }

</style>

<div id="images"></div>

<script type="text/javascript" charset="utf-8">
    $(document).ready(function() {
        $.getJSON("http://flickrit.pboehm.org/photos/phboehm", function(data){
            $.each(data, function(i,item){
                var image =
                    '<div class="flickr_image_container">' +
                    '<a class="flickr_image" href="' + item.photo_url + '">' +
                    '<img class="lazy" data-original="' + item.url_z +
                    '"/></a><p class="flickr_image_title">' + item.title +
                    '</p></div>';
                $(image).appendTo("#images");
            });
            $("img.lazy").lazyload({
                effect : "fadeIn"
            });
        });
    });
</script>
