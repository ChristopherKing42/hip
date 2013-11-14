{-# LANGUAGE TypeFamilies #-}

data Gray p = Gray p
            | GrayA p p

data Color p = RGB p p p
             | RGBA p p p p

data Complex px = px :+: px

type family Pixel px :: *

data Numeric px = Numeric px

type instance Pixel (Gray Double) = Numeric Double

type instance Pixel (Color Double) = Numeric Double

type instance Pixel (Complex px) = Numeric px

instance Num (Numeric px) where
  (+) = (+)


class Summable f where
  plus :: f a -> f b -> f c

instance Summable Numeric where
  plus p1 p2 = Numeric (p1 + p2)

instance Num p => Num (Gray p) where
  (Gray p1) + (Gray p2) = Gray (p1 + p2)

instance Num p => Num (Color p) where
  (RGB r1 g1 b1) + (RGB r2 g2 b2) = RGB (r1 + r2) (g1 + g2) (b1 + b2)


{-
data Image p = ColorImage (Color p)
             | GrayImage ( Gray p)

instance Summable Image where
  plus op (ColorImage px1) (GrayImage px2) = ColorImage (op px1 px2)
-}
