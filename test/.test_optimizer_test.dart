// GENERATED CODE - DO NOT MODIFY BY HAND
// Consider adding this file to your .gitignore.

import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';


import 'about_us/about_us_widget_test.dart' as _a;
import 'app/app_widget_test.dart' as _b;
import 'bloc/app_version/app_version_cubit_test.dart' as _c;
import 'bloc/authentication/authentication_bloc_test.dart' as _d;
import 'bloc/authentication/authentication_repository_stream_test.dart' as _e;
import 'bloc/authentication/authentication_repository_test.dart' as _f;
import 'bloc/authentication_services_cubit_unit_test.dart' as _g;
import 'bloc/filter_cubit_unit_test.dart' as _h;
import 'bloc/image_model_test.dart' as _i;
import 'bloc/mob_feedback_bloc_test.dart' as _j;
import 'bloc/mob_offline_mode_cubit_test.dart' as _k;
import 'bloc/network/network_bloc_test.dart' as _l;
import 'bloc/network/network_repository_test.dart' as _m;
import 'bloc/report/report_bloc_test.dart' as _n;
import 'bloc/report/report_model_test.dart' as _o;
import 'bloc/report/report_repository_test.dart' as _p;
import 'bloc/url_cubit_test.dart' as _q;
import 'business_dashboard/business_dashboard_widget_test.dart' as _r;
import 'consultation/consultation_widget_test.dart' as _s;
import 'contact/contact_widget_test.dart' as _t;
import 'data_provider/cashe_provider_test.dart' as _u;
import 'data_provider/firestore/firestore_provider_discounts_test.dart' as _v;
import 'data_provider/firestore/firestore_provider_feedback_test.dart' as _w;
import 'data_provider/firestore/firestore_provider_fund_test.dart' as _x;
import 'data_provider/firestore/firestore_provider_inforamtion_test.dart' as _y;
import 'data_provider/firestore/firestore_provider_question_test.dart' as _z;
import 'data_provider/firestore/firestore_provider_story_test.dart' as _A;
import 'data_provider/firestore/firestore_provider_user_setting_test.dart' as _B;
import 'data_provider/firestore/firestore_provider_work_test.dart' as _C;
import 'data_provider/storage/storage_provider_test.dart' as _D;
import 'discounts/discounts_mob_widget_test.dart' as _E;
import 'discounts/discounts_widget_test.dart' as _F;
import 'discounts/unit_test/advanced_filter_mob_cuibit_test.dart' as _G;
import 'discounts/unit_test/discount_bloc_test.dart' as _H;
import 'discounts/unit_test/discount_config_cubit_test.dart' as _I;
import 'discounts/unit_test/discount_model_test.dart' as _J;
import 'discounts/unit_test/discount_repository_test.dart' as _K;
import 'discounts/unit_test/link/discount_link_cubit_test.dart' as _L;
import 'discounts/unit_test/link/discount_link_form_bloc_test.dart' as _M;
import 'discounts/unit_test/link/discount_link_model_test.dart' as _N;
import 'discounts/unit_test/user_email/discount_user_email_bloc_test.dart' as _O;
import 'discounts/unit_test/user_email/discount_user_email_cubit_test.dart' as _P;
import 'discounts/unit_test/user_email/discount_user_email_model_test.dart' as _Q;
import 'discounts_add/discounts_add_unit_test.dart' as _R;
import 'discounts_add/discounts_add_widget_test.dart' as _S;
import 'discount_card/discount_card_unit_test.dart' as _T;
import 'discount_card/discount_card_widget_test.dart' as _U;
import 'employee_respond/employee_respond_widget_test.dart' as _V;
import 'employee_respond/unit_test/employee_respond_bloc_test.dart' as _W;
import 'employee_respond/unit_test/employee_respond_model_test.dart' as _X;
import 'error/error_test.dart' as _Y;
import 'feedback/feedback_mob_widget_test.dart' as _Z;
import 'feedback/feedback_widget_test.dart' as _aa;
import 'feedback/unit_test/feedback_bloc_test.dart' as _ba;
import 'feedback/unit_test/feedback_field_model_test.dart' as _ca;
import 'feedback/unit_test/feedback_model_test.dart' as _da;
import 'feedback/unit_test/feedback_repository_test.dart' as _ea;
import 'home/home_prod_widget_test.dart' as _fa;
import 'home/home_widget_test.dart' as _ga;
import 'home/unit_test/home_bloc_test.dart' as _ha;
import 'home/unit_test/home_model_test.dart' as _ia;
import 'information/information_widget_test.dart' as _ja;
import 'information/unit_test/information_bloc_test.dart' as _ka;
import 'information/unit_test/information_model_test.dart' as _la;
import 'information/unit_test/information_repository_test.dart' as _ma;
import 'investors/investors_mob_widget_test.dart' as _na;
import 'investors/investors_widget_test.dart' as _oa;
import 'investors/unit_test/investors_bloc_test.dart' as _pa;
import 'investors/unit_test/investors_model_test.dart' as _qa;
import 'investors/unit_test/investors_repository_test.dart' as _ra;
import 'login/login_unit_test.dart' as _sa;
import 'login/login_widget_test.dart' as _ta;
import 'mob_faq/mob_faq_unit_test.dart' as _ua;
import 'mob_faq/mob_faq_widget_test.dart' as _va;
import 'mob_settings/mob_settings_widget_test.dart' as _wa;
import 'model/field_model/password_field_model_test.dart' as _xa;
import 'model/image_model_test.dart' as _ya;
import 'model/resume_model_test.dart' as _za;
import 'model/translate_model_test.dart' as _Aa;
import 'my_discounts/my_discounts_widget_test.dart' as _Ba;
import 'my_discounts/unit_test/discounts_repository_test.dart' as _Ca;
import 'my_discounts/unit_test/my_discounts_bloc_test.dart' as _Da;
import 'my_story/my_story_widget_test.dart' as _Ea;
import 'my_story/unit_test/my_story_bloc_test.dart' as _Fa;
import 'my_story/unit_test/story_repository_test.dart' as _Ga;
import 'news_card/news_card_unit_test.dart' as _Ha;
import 'news_card/news_card_widget_test.dart' as _Ia;
import 'password_reset/password_reset_widget_test.dart' as _Ja;
import 'password_reset/unit_test/check_verification_code_cubit_test.dart' as _Ka;
import 'password_reset/unit_test/password_reset_bloc_test.dart' as _La;
import 'privacy_policy/privacy_policy_unit_test.dart' as _Ma;
import 'privacy_policy/privacy_policy_widget_test.dart' as _Na;
import 'profile/profile_widget_test.dart' as _Oa;
import 'profile/unit_test/profile_bloc_test.dart' as _Pa;
import 'profile_saves/profile_saves_widget_test.dart' as _Qa;
import 'pw_reset_email/pw_reset_email_unit_test.dart' as _Ra;
import 'pw_reset_email/pw_reset_email_widget_test.dart' as _Sa;
import 'questions_form/question_form_widget_test.dart' as _Ta;
import 'repository/app_authentication/app_authentication_repository_success_not_web_test.dart' as _Ua;
import 'repository/app_authentication/app_authentication_repository_success_test.dart' as _Va;
import 'repository/app_authentication/app_authetication_failure_get_repository_test.dart' as _Wa;
import 'repository/app_authentication/app_authetication_failure_repository_test.dart' as _Xa;
import 'repository/app_authentication/app_authetication_firebase_failure_repository_test.dart' as _Ya;
import 'repository/app_authentication/user_model_test.dart' as _Za;
import 'repository/app_authentication/user_setting_model_test.dart' as _ab;
import 'repository/app_network_repository_test.dart' as _bb;
import 'repository/cities/cities_repositry_test.dart' as _cb;
import 'repository/cities/city_model_test.dart' as _db;
import 'repository/device/device_info_model_test.dart' as _eb;
import 'repository/device/device_repository_test.dart' as _fb;
import 'repository/faq_repository_test.dart' as _gb;
import 'repository/secura_storage_repository_test.dart' as _hb;
import 'sign_up/sign_up_unit_test.dart' as _ib;
import 'sign_up/sign_up_widget_test.dart' as _jb;
import 'story/story_widget_test.dart' as _kb;
import 'story/unit_test/story_bloc_test.dart' as _lb;
import 'story/unit_test/story_model_test.dart' as _mb;
import 'story/unit_test/story_repository_test.dart' as _nb;
import 'story_add/story_add_widget_test.dart' as _ob;
import 'story_add/unit_test/story_add_bloc_correct_test.dart' as _pb;
import 'story_add/unit_test/story_add_bloc_uncorrect_test.dart' as _qb;
import 'story_add/unit_test/story_add_repository_test.dart' as _rb;
import 'thank/thank_widget_test.dart' as _sb;
import 'user_role/user_role_widget_test.dart' as _tb;
import 'work/work_widget_test.dart' as _ub;
import 'work_employee/unit_test/work_employee_bloc_test.dart' as _vb;
import 'work_employee/unit_test/work_employee_model_test.dart' as _wb;
import 'work_employee/unit_test/work_employee_repository_test.dart' as _xb;
import 'work_employee/work_employee_widget_test.dart' as _yb;
import 'work_employer/work_employer_widget_test.dart' as _zb;

void main() {
  goldenFileComparator = _TestOptimizationAwareGoldenFileComparator(goldenFileComparator as LocalFileComparator);
  group('about_us/about_us_widget_test.dart', () { _a.main(); });
  group('app/app_widget_test.dart', () { _b.main(); });
  group('bloc/app_version/app_version_cubit_test.dart', () { _c.main(); });
  group('bloc/authentication/authentication_bloc_test.dart', () { _d.main(); });
  group('bloc/authentication/authentication_repository_stream_test.dart', () { _e.main(); });
  group('bloc/authentication/authentication_repository_test.dart', () { _f.main(); });
  group('bloc/authentication_services_cubit_unit_test.dart', () { _g.main(); });
  group('bloc/filter_cubit_unit_test.dart', () { _h.main(); });
  group('bloc/image_model_test.dart', () { _i.main(); });
  group('bloc/mob_feedback_bloc_test.dart', () { _j.main(); });
  group('bloc/mob_offline_mode_cubit_test.dart', () { _k.main(); });
  group('bloc/network/network_bloc_test.dart', () { _l.main(); });
  group('bloc/network/network_repository_test.dart', () { _m.main(); });
  group('bloc/report/report_bloc_test.dart', () { _n.main(); });
  group('bloc/report/report_model_test.dart', () { _o.main(); });
  group('bloc/report/report_repository_test.dart', () { _p.main(); });
  group('bloc/url_cubit_test.dart', () { _q.main(); });
  group('business_dashboard/business_dashboard_widget_test.dart', () { _r.main(); });
  group('consultation/consultation_widget_test.dart', () { _s.main(); });
  group('contact/contact_widget_test.dart', () { _t.main(); });
  group('data_provider/cashe_provider_test.dart', () { _u.main(); });
  group('data_provider/firestore/firestore_provider_discounts_test.dart', () { _v.main(); });
  group('data_provider/firestore/firestore_provider_feedback_test.dart', () { _w.main(); });
  group('data_provider/firestore/firestore_provider_fund_test.dart', () { _x.main(); });
  group('data_provider/firestore/firestore_provider_inforamtion_test.dart', () { _y.main(); });
  group('data_provider/firestore/firestore_provider_question_test.dart', () { _z.main(); });
  group('data_provider/firestore/firestore_provider_story_test.dart', () { _A.main(); });
  group('data_provider/firestore/firestore_provider_user_setting_test.dart', () { _B.main(); });
  group('data_provider/firestore/firestore_provider_work_test.dart', () { _C.main(); });
  group('data_provider/storage/storage_provider_test.dart', () { _D.main(); });
  group('discounts/discounts_mob_widget_test.dart', () { _E.main(); });
  group('discounts/discounts_widget_test.dart', () { _F.main(); });
  group('discounts/unit_test/advanced_filter_mob_cuibit_test.dart', () { _G.main(); });
  group('discounts/unit_test/discount_bloc_test.dart', () { _H.main(); });
  group('discounts/unit_test/discount_config_cubit_test.dart', () { _I.main(); });
  group('discounts/unit_test/discount_model_test.dart', () { _J.main(); });
  group('discounts/unit_test/discount_repository_test.dart', () { _K.main(); });
  group('discounts/unit_test/link/discount_link_cubit_test.dart', () { _L.main(); });
  group('discounts/unit_test/link/discount_link_form_bloc_test.dart', () { _M.main(); });
  group('discounts/unit_test/link/discount_link_model_test.dart', () { _N.main(); });
  group('discounts/unit_test/user_email/discount_user_email_bloc_test.dart', () { _O.main(); });
  group('discounts/unit_test/user_email/discount_user_email_cubit_test.dart', () { _P.main(); });
  group('discounts/unit_test/user_email/discount_user_email_model_test.dart', () { _Q.main(); });
  group('discounts_add/discounts_add_unit_test.dart', () { _R.main(); });
  group('discounts_add/discounts_add_widget_test.dart', () { _S.main(); });
  group('discount_card/discount_card_unit_test.dart', () { _T.main(); });
  group('discount_card/discount_card_widget_test.dart', () { _U.main(); });
  group('employee_respond/employee_respond_widget_test.dart', () { _V.main(); });
  group('employee_respond/unit_test/employee_respond_bloc_test.dart', () { _W.main(); });
  group('employee_respond/unit_test/employee_respond_model_test.dart', () { _X.main(); });
  group('error/error_test.dart', () { _Y.main(); });
  group('feedback/feedback_mob_widget_test.dart', () { _Z.main(); });
  group('feedback/feedback_widget_test.dart', () { _aa.main(); });
  group('feedback/unit_test/feedback_bloc_test.dart', () { _ba.main(); });
  group('feedback/unit_test/feedback_field_model_test.dart', () { _ca.main(); });
  group('feedback/unit_test/feedback_model_test.dart', () { _da.main(); });
  group('feedback/unit_test/feedback_repository_test.dart', () { _ea.main(); });
  group('home/home_prod_widget_test.dart', () { _fa.main(); });
  group('home/home_widget_test.dart', () { _ga.main(); });
  group('home/unit_test/home_bloc_test.dart', () { _ha.main(); });
  group('home/unit_test/home_model_test.dart', () { _ia.main(); });
  group('information/information_widget_test.dart', () { _ja.main(); });
  group('information/unit_test/information_bloc_test.dart', () { _ka.main(); });
  group('information/unit_test/information_model_test.dart', () { _la.main(); });
  group('information/unit_test/information_repository_test.dart', () { _ma.main(); });
  group('investors/investors_mob_widget_test.dart', () { _na.main(); });
  group('investors/investors_widget_test.dart', () { _oa.main(); });
  group('investors/unit_test/investors_bloc_test.dart', () { _pa.main(); });
  group('investors/unit_test/investors_model_test.dart', () { _qa.main(); });
  group('investors/unit_test/investors_repository_test.dart', () { _ra.main(); });
  group('login/login_unit_test.dart', () { _sa.main(); });
  group('login/login_widget_test.dart', () { _ta.main(); });
  group('mob_faq/mob_faq_unit_test.dart', () { _ua.main(); });
  group('mob_faq/mob_faq_widget_test.dart', () { _va.main(); });
  group('mob_settings/mob_settings_widget_test.dart', () { _wa.main(); });
  group('model/field_model/password_field_model_test.dart', () { _xa.main(); });
  group('model/image_model_test.dart', () { _ya.main(); });
  group('model/resume_model_test.dart', () { _za.main(); });
  group('model/translate_model_test.dart', () { _Aa.main(); });
  group('my_discounts/my_discounts_widget_test.dart', () { _Ba.main(); });
  group('my_discounts/unit_test/discounts_repository_test.dart', () { _Ca.main(); });
  group('my_discounts/unit_test/my_discounts_bloc_test.dart', () { _Da.main(); });
  group('my_story/my_story_widget_test.dart', () { _Ea.main(); });
  group('my_story/unit_test/my_story_bloc_test.dart', () { _Fa.main(); });
  group('my_story/unit_test/story_repository_test.dart', () { _Ga.main(); });
  group('news_card/news_card_unit_test.dart', () { _Ha.main(); });
  group('news_card/news_card_widget_test.dart', () { _Ia.main(); });
  group('password_reset/password_reset_widget_test.dart', () { _Ja.main(); });
  group('password_reset/unit_test/check_verification_code_cubit_test.dart', () { _Ka.main(); });
  group('password_reset/unit_test/password_reset_bloc_test.dart', () { _La.main(); });
  group('privacy_policy/privacy_policy_unit_test.dart', () { _Ma.main(); });
  group('privacy_policy/privacy_policy_widget_test.dart', () { _Na.main(); });
  group('profile/profile_widget_test.dart', () { _Oa.main(); });
  group('profile/unit_test/profile_bloc_test.dart', () { _Pa.main(); });
  group('profile_saves/profile_saves_widget_test.dart', () { _Qa.main(); });
  group('pw_reset_email/pw_reset_email_unit_test.dart', () { _Ra.main(); });
  group('pw_reset_email/pw_reset_email_widget_test.dart', () { _Sa.main(); });
  group('questions_form/question_form_widget_test.dart', () { _Ta.main(); });
  group('repository/app_authentication/app_authentication_repository_success_not_web_test.dart', () { _Ua.main(); });
  group('repository/app_authentication/app_authentication_repository_success_test.dart', () { _Va.main(); });
  group('repository/app_authentication/app_authetication_failure_get_repository_test.dart', () { _Wa.main(); });
  group('repository/app_authentication/app_authetication_failure_repository_test.dart', () { _Xa.main(); });
  group('repository/app_authentication/app_authetication_firebase_failure_repository_test.dart', () { _Ya.main(); });
  group('repository/app_authentication/user_model_test.dart', () { _Za.main(); });
  group('repository/app_authentication/user_setting_model_test.dart', () { _ab.main(); });
  group('repository/app_network_repository_test.dart', () { _bb.main(); });
  group('repository/cities/cities_repositry_test.dart', () { _cb.main(); });
  group('repository/cities/city_model_test.dart', () { _db.main(); });
  group('repository/device/device_info_model_test.dart', () { _eb.main(); });
  group('repository/device/device_repository_test.dart', () { _fb.main(); });
  group('repository/faq_repository_test.dart', () { _gb.main(); });
  group('repository/secura_storage_repository_test.dart', () { _hb.main(); });
  group('sign_up/sign_up_unit_test.dart', () { _ib.main(); });
  group('sign_up/sign_up_widget_test.dart', () { _jb.main(); });
  group('story/story_widget_test.dart', () { _kb.main(); });
  group('story/unit_test/story_bloc_test.dart', () { _lb.main(); });
  group('story/unit_test/story_model_test.dart', () { _mb.main(); });
  group('story/unit_test/story_repository_test.dart', () { _nb.main(); });
  group('story_add/story_add_widget_test.dart', () { _ob.main(); });
  group('story_add/unit_test/story_add_bloc_correct_test.dart', () { _pb.main(); });
  group('story_add/unit_test/story_add_bloc_uncorrect_test.dart', () { _qb.main(); });
  group('story_add/unit_test/story_add_repository_test.dart', () { _rb.main(); });
  group('thank/thank_widget_test.dart', () { _sb.main(); });
  group('user_role/user_role_widget_test.dart', () { _tb.main(); });
  group('work/work_widget_test.dart', () { _ub.main(); });
  group('work_employee/unit_test/work_employee_bloc_test.dart', () { _vb.main(); });
  group('work_employee/unit_test/work_employee_model_test.dart', () { _wb.main(); });
  group('work_employee/unit_test/work_employee_repository_test.dart', () { _xb.main(); });
  group('work_employee/work_employee_widget_test.dart', () { _yb.main(); });
  group('work_employer/work_employer_widget_test.dart', () { _zb.main(); });
}


class _TestOptimizationAwareGoldenFileComparator extends GoldenFileComparator {
  final List<String> goldenFilePaths;
  final LocalFileComparator previousGoldenFileComparator;

  _TestOptimizationAwareGoldenFileComparator(this.previousGoldenFileComparator)
      : goldenFilePaths = _goldenFilePaths;

  static List<String> get _goldenFilePaths =>
      Directory.fromUri((goldenFileComparator as LocalFileComparator).basedir)
          .listSync(recursive: true, followLinks: true)
          .whereType<File>()
          .map((file) => file.path)
          .where((path) => path.endsWith('.png'))
          .toList();
  @override
  Future<bool> compare(Uint8List imageBytes, Uri golden)  => previousGoldenFileComparator.compare(imageBytes, golden);

  @override
  Uri getTestUri(Uri key, int? version) {
    final keyString = key.toFilePath();
    return Uri.parse(goldenFilePaths
        .singleWhere((goldenFilePath) => goldenFilePath.endsWith(keyString)));
  }

  @override
  Future<void> update(Uri golden, Uint8List imageBytes) => previousGoldenFileComparator.update(golden, imageBytes);

}
