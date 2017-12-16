﻿using System;
using Xamarin.Forms;

namespace XamarinForms.Extensions.Controls
{
    public class Checkbox : Button
    {
        private const string NotDone = "☐";
        private const string Done = "☑";

        public Checkbox()
        {
            //base.Image = "Assets/checkbox.png";
            base.Clicked += new EventHandler(OnClicked);
            base.BackgroundColor = Color.White;
            base.TextColor = Color.Accent;
            base.Text = NotDone;
            base.BorderWidth = 0;
        }

        public static BindableProperty CheckedProperty = BindableProperty.Create(
            propertyName: "Checked",
            returnType: typeof(Boolean?),
            declaringType: typeof(Checkbox),
            defaultValue: null,
            defaultBindingMode: BindingMode.TwoWay,
            propertyChanged: CheckedValueChanged);

        public Boolean? Checked
        {
            get
            {
                if (GetValue(CheckedProperty) == null)
                {
                    return null;
                }
                return (Boolean)GetValue(CheckedProperty);
            }
            set
            {
                SetValue(CheckedProperty, value);
                OnPropertyChanged();
                RaiseCheckedChanged();
            }
        }

        private static void CheckedValueChanged(BindableObject bindable, object oldValue, object newValue)
        {

                Checkbox checkbox = ((Checkbox)bindable);
            if (newValue != null && (Boolean)newValue == true)
            {
                //((Checkbox)bindable).Image = "checkedimage.png";
                checkbox.Text = Done;
            }
            else
            {
                //((Checkbox)bindable).Image = "uncheckedimage.png";

                checkbox.Text = NotDone;
            }
        }

        public event EventHandler CheckedChanged;
        private void RaiseCheckedChanged()
        {
            CheckedChanged?.Invoke(this, EventArgs.Empty);
        }


        public void OnClicked(object sender, EventArgs e)
        {
            Checked = !Checked;
        }

    }

}
