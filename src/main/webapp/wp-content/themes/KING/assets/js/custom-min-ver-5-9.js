! function() {
    function e(e, t, s) {
        var n = e,
            i = n.parent().data("category"),
            a, l = s;
        t.find("li").removeClass("active"), n.parent().addClass("active"), "all" === i ? s.find(".col-md-4").fadeIn(400) : s.find(".col-md-4").each(function() {
            var e = $(this),
                t = e.data("category");
            i !== t ? e.fadeOut(300) : e.fadeIn(500)
        })
    }
    if ($(".navbar-toggler").click(function() {
            $(this).toggleClass("is-open"), $("#navbarNav").toggleClass("is-open")
        }), $('.section-search input[type="image"]').attr("src", "https://tapestryjournal.com.au/wp-content/themes/KING/assets/images/search-icon.svg"), $(".collapsible-block .header").click(function() {
            $(".collapsible-block .header").each(function() {
                var e = $(this),
                    t = setTimeout(function() {
                        var t;
                        "true" === e.attr("aria-expanded") ? e.find(".chevron-btn").addClass("close-btn") : e.find(".chevron-btn").removeClass("close-btn")
                    }, 200)
            })
        }), $(".page-id-172").length && $(".filter-search li a").click(function(t) {
            t.preventDefault(), e($(this), $(".filter-search"), $("section.section-article-single"))
        }), $("input#search").on("keyup", function() {
            var e, t, s, n, i, a, l, c;
            e = document.getElementById("search"), t = e.value.toUpperCase(), $("section.section-article-single").find(".col-md-4").each(function() {
                var e = $(this),
                    s;
                e.find("h4").data("title").toUpperCase().indexOf(t) > -1 ? e.css("display", "block") : e.css("display", "none")
            })
        }), $(".single-post").length) {
        var t = 0;
        $(".section-article-content p").each(function() {
            if ($(this).find("img").length > 1) {
                console.log("Yes");
                var e, t = "calc(100%/" + $(this).find("img").length + " - 20px)";
                $(this).find("img").each(function() {
                    $(this).css("max-width", t)
                })
            }
        })
    }
    $("#plan-input").change(function() {
        if ($(this).val() >= 10 && $(this).val() <= 400) {
            var e;
            Number($(this).val()) % 10 != 0 ? (console.log(10 * (parseInt(Number($(this).val()) / 10, 10) + 1)), $(this).val(10 * (parseInt(Number($(this).val()) / 10, 10) + 1)), e = 10 * (parseInt(Number($(this).val()) / 10, 10) + 1) - 10) : e = $(this).val(), console.log(e);
            var t = $(".list-of-plans .item-" + e).data("val"),
                s = $(".list-of-plans .item-" + e).data("inctax");
            $(".result span").html(t), $(".sub-text span").html(s)
        } else alert("Please insert a value between 10 and 400"), $(this).val("10"), $(".result span").html($(".list-of-plans .item-10").data("val")), $(".sub-text span").html($(".list-of-plans .item-10").data("inctax"))
    });
    const s = $(".section-testimonial-quotes");
    s.each(function() {
        const e = $(this),
            t = $(this).find(".load-more-btn");
        t.click(function(s) {
            s.preventDefault();
            const n = e.find(".hide-quote:first");
            n.removeClass("hide-quote"), n.nextAll().slice(0, 2).removeClass("hide-quote"), 0 === e.find(".hide-quote").length && t.hide()
        })
    })
}(),
function() {
    var e, t, s, n, i, a, l;
    for (e = document.getElementsByClassName("custom-select"), t = 0; t < e.length; t++) {
        for (n = e[t].getElementsByTagName("select")[0], (i = document.createElement("DIV")).setAttribute("class", "select-selected"), i.innerHTML = n.options[n.selectedIndex].innerHTML, e[t].appendChild(i), (a = document.createElement("DIV")).setAttribute("class", "select-items select-hide"), s = 1; s < n.length; s++)(l = document.createElement("DIV")).innerHTML = n.options[s].innerHTML, l.addEventListener("click", function(e) {
            var t, s, n, i, a;
            for (i = this.parentNode.parentNode.getElementsByTagName("select")[0], a = this.parentNode.previousSibling, s = 0; s < i.length; s++)
                if (i.options[s].innerHTML === this.innerHTML) {
                    for ($(".result span").html(i.options[s].value), $(".sub-text span").html(i.options[s].dataset.inctax), i.selectedIndex = s, a.innerHTML = this.innerHTML, t = this.parentNode.getElementsByClassName("same-as-selected"), n = 0; n < t.length; n++) t[n].removeAttribute("class");
                    this.setAttribute("class", "same-as-selected");
                    break
                }
            a.click()
        }), a.appendChild(l);
        e[t].appendChild(a), i.addEventListener("click", function(e) {
            e.stopPropagation(), c(this), this.nextSibling.classList.toggle("select-hide"), this.classList.toggle("select-arrow-active")
        })
    }

    function c(e) {
        var t, s, n, i = [];
        for (t = document.getElementsByClassName("select-items"), s = document.getElementsByClassName("select-selected"), n = 0; n < s.length; n++) e === s[n] ? i.push(n) : s[n].classList.remove("select-arrow-active");
        for (n = 0; n < t.length; n++) i.indexOf(n) && t[n].classList.add("select-hide")
    }
    document.addEventListener("click", c)
}(), $(document).ready(function() {
    function e(e) {
        e.swipe({
            swipe: function(e, t, s, n, i, a) {
                "left" === t && $(this).find(".carousel-control-next").trigger("click"), "right" === t && $(this).find(".carousel-control-prev").trigger("click")
            },
            allowPageScroll: "vertical",
            preventDefaultEvents: !1
        })
    }
    var t = $("#carouselFeaturesMobile")
});