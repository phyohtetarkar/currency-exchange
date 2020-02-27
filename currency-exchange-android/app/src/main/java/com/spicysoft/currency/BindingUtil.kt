package com.spicysoft.currency

import android.widget.ImageView
import androidx.databinding.BindingAdapter
import java.util.*

object BindingUtil {

    @JvmStatic
    @BindingAdapter("app:image")
    fun setImage(imageView: ImageView, name: String?) {
        name?.toLowerCase(Locale.ENGLISH)?.also {
            val resources = imageView.context.resources
            val resourceId = resources.getIdentifier(it, "drawable", imageView.context.packageName)
            if (resourceId > 0) {
                imageView.setImageDrawable(resources.getDrawable(resourceId, null))
            }
        }
    }

}